#!/usr/bin/env elixir

defmodule Ros2PrepareResources do
  @shortdoc "Prepare ROS 2 resources under .ros2 directory."
  @moduledoc """
  #{@shortdoc}


  ROS 2 resources will be prepared under .ros2.
  """

  @arm64v8_ros_distros ["foxy", "galactic", "humble"]
  @amd64_ros_distros ["foxy", "galactic", "humble"]
  @arm32v7_ros_distros ["foxy", "humble"]
  @supported_ros_distros %{
    "arm64v8" => @arm64v8_ros_distros,
    "amd64" => @amd64_ros_distros,
    "arm32v7" => @arm32v7_ros_distros
  }
  @supported_arch Map.keys(@supported_ros_distros)
  @switches [arch: :string]

  @doc false
  def main(_args) do
    if not command_exists?("docker") do
      IO.puts("""
      Please install docker command first, we need it.
      """)
      System.halt(1)
    end

    ros_arch = System.get_env("ROS_ARCH")

    if ros_arch not in @supported_arch do
      IO.puts("""
      Please select and specify the appropriate ROS_ARCH from the following.
      #{Enum.join(@supported_arch, ", ")}
      """)
      System.halt(1)
    end

    ros_distro = System.get_env("ROS_DISTRO")
    supported_ros_distros = Map.get(@supported_ros_distros, ros_arch, [])

    if ros_distro not in supported_ros_distros do
      IO.puts("""
      Please set the appropriate ROS_DISTRO from the following.
      #{Enum.join(supported_ros_distros, ", ")}
      """)
      System.halt(1)
    end

    dest_dir_path = copy_dest_dir_path(ros_arch)

    copy_from_docker!(dest_dir_path, ros_arch, ros_distro)

    :ok
  end

  @doc false
  def ask_yes_no(message) do
    answer = IO.gets("#{message} (y/n): ")
            |> String.trim()
            |> String.downcase()

    case answer do
      "y" -> true
      "yes" -> true
      "n" -> false
      "no" -> false
      _ ->
        IO.puts("Invalid input. Please enter 'y' or 'n'.")
        ask_yes_no(message)
    end
  end

  @doc false
  def command_exists?(command) when is_binary(command) do
    case System.cmd("sh", ["-c", "command -v #{command}"]) do
      {_, 0} -> true
      _ -> false
    end
  end

  @doc false
  def parse_args(args) do
    {parsed_args, _remaining_args, _invalid} = OptionParser.parse(args, strict: @switches)

    parsed_args
  end

  @doc false
  def copy_from_docker!(dest_dir_path, arch, ros_distro) do
    dest_path = Path.join(dest_dir_path, "/opt/ros/#{ros_distro}")
    create_resources_directory!(dest_path)
    copy_ros_resources_from_docker!(dest_path, arch, ros_distro)

    dest_path = Path.join(dest_dir_path, "/opt/ros/#{ros_distro}/lib")
    create_resources_directory!(dest_path)
    copy_vendor_resources_from_docker!(dest_path, arch, ros_distro)
  end

  defp copy_ros_resources_from_docker!(dest_path, arch, ros_distro)
       when arch in ["arm64v8", "amd64"] do
    [
      "/opt/ros/#{ros_distro}/include",
      "/opt/ros/#{ros_distro}/lib",
      "/opt/ros/#{ros_distro}/share"
    ]
    |> Enum.map(fn src_path -> copy_from_docker_impl!(arch, ros_distro, src_path, dest_path) end)
  end

  defp copy_ros_resources_from_docker!(dest_path, arch, ros_distro)
       when arch in ["arm32v7"] do
    [
      "/root/ros2_ws/install/*/include",
      "/root/ros2_ws/install/*/lib",
      "/root/ros2_ws/install/*/share"
    ]
    |> Enum.map(fn src_path -> copy_from_docker_impl!(arch, ros_distro, src_path, dest_path) end)
  end

  defp copy_vendor_resources_from_docker!(dest_path, arch, ros_distro)
       when arch in ["arm64v8", "amd64", "arm32v7"] do
    vendor_resources(arch, ros_distro)
    |> Enum.map(fn src_path -> copy_from_docker_impl!(arch, ros_distro, src_path, dest_path) end)
  end

  defp vendor_resources(arch, "humble") do
    dir_name = arch_dir_name(arch)

    [
      "/lib/#{dir_name}/libspdlog.so*",
      "/lib/#{dir_name}/libtinyxml2.so*",
      "/lib/#{dir_name}/libfmt.so*",
      # humble needs OpenSSL 3.x which Nerves doesn't have
      "/lib/#{dir_name}/libssl.so*",
      "/lib/#{dir_name}/libcrypto.so*"
    ]
  end

  defp vendor_resources(arch, "galactic") do
    dir_name = arch_dir_name(arch)

    [
      "/lib/#{dir_name}/libspdlog.so*",
      "/usr/lib/#{dir_name}/libacl.so*"
    ]
  end

  defp vendor_resources(arch, "foxy") do
    dir_name = arch_dir_name(arch)

    [
      "/lib/#{dir_name}/libspdlog.so*",
      "/lib/#{dir_name}/libtinyxml2.so*"
    ]
  end

  defp copy_from_docker_impl!(arch, ros_distro, src_path, dest_path) do
    with true <- File.exists?(dest_path) do
      docker_tag = ros_docker_image_tag(arch, ros_distro)
      docker_platform = case arch do
        "arm32v7" -> "linux/arm/v7"
        "arm64v8" -> "linux/arm64"
        _         -> "linux/amd64"
      end
      docker_command_args = ["run", "--platform", "#{docker_platform}", "--rm", "-v", "#{dest_path}:/mnt", docker_tag]
      copy_command = ["bash", "-c", "for s in #{src_path}; do cp -rf $s /mnt; done"]

      {_, 0} = System.cmd("docker", docker_command_args ++ copy_command)
    end
  end

  def ros_docker_image_tag("arm32v7", ros_distro) when ros_distro in @arm32v7_ros_distros do
    "rclex/arm32v7_ros_docker_with_vendor_resources:#{ros_distro}"
  end

  @doc false
  def ros_docker_image_tag(_arch, ros_distro) do
    "ros:#{ros_distro}-ros-core"
  end

  defp arch_dir_name("arm64v8"), do: "aarch64-linux-gnu"
  defp arch_dir_name("amd64"), do: "x86_64-linux-gnu"
  defp arch_dir_name("arm32v7"), do: "arm-linux-gnueabihf"

  @doc false
  @spec create_resources_directory!(directory_path :: String.t()) :: :ok
  def create_resources_directory!(directory_path) do
    File.mkdir_p!(directory_path)
  end

  defp copy_dest_dir_path(ros_arch) do
    Path.join(__ENV__.file |> Path.dirname(), "../.ros2/#{ros_arch}/")
  end
end

Ros2PrepareResources.main(System.argv())
