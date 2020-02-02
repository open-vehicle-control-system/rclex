defmodule RclEx do
  @on_load :load_nifs
    def load_nifs do
        IO.puts "load_nifs"
        :erlang.load_nif('/home/imanishi/rclex/rclex',0)
    end
  #-----------------------init_nif.c--------------------------
  #return rcl_init_options_t
  def rcl_get_zero_initialized_init_options do
    raise "NIF rcl_get_zero_initialized_init_options/0 not implemented"
  end
  def rcl_init_options_init(_a) do
    raise "NIF rcl_init_options_init/1 is not implemented"
  end

  def rcl_init_options_fini(_a) do
    raise "NIF rcl_init_options_fini/1 is not implemented"
  end
  #return rcl_context_t
  def rcl_get_zero_initialized_context do
      raise "NIF rcl_get_zero_initialized_context/0 not implemented"
  end
  #def nif_read_context(_a) do
  #    raise "NIF nif_read_context/1 is not implemented"
  #end
  @doc """
      return {:ok,rcl_ret_t}
      arguments...(
          int argc,
          char const * const * argv,
          const rcl_init_options_t * options,
          rcl_context_t * context)
        argc,argvに0,NULLを直接入れる関数
  """
  def rcl_init_with_null(_a,_b) do
      raise "NIF rcl_init_with_null/2 not implemented"
  end
  @doc """
      return {:ok,rcl_ret_t}
      arguments...(
          rcl_context_t)
  """
  def rcl_shutdown(_a) do
      raise "NIF rcl_shutdown/1 not implemented"
  end

  #-----------------------node_nif.c--------------------------
  #return {:ok,rcl_node_t}
  def rcl_get_zero_initialized_node do
    raise "NIF rcl_get_zero_initialized_node/0 not implemented"
  end

  #return {:ok,rcl_node_options_t}
  def rcl_node_get_default_options do
      raise "NIF rcl_node_get_default_options/0 not implemented"
  end
  @doc """
      return {:ok,rcl_ret_t}
      argument...(
      rcl_node_t * node,
      const char * name,
      const char * namespace_,
      rcl_context_t * context,
      const rcl_node_options_t * options)
  """
  def rcl_node_init(_a,_b,_c,_d,_e) do
      raise "NIF rcl_node_init/5 not implemented"
  end
  def rcl_node_init_without_namespace(_a,_b,_c,_d) do
      raise "NIF rcl_node_init_without_namespace/4 is not implemented"
  end
  def express_node_init do
      raise "sorry"
  end
  @doc """
      return rcl_ret_t
      argument...rcl_node_t
  """
  def rcl_node_fini(_a) do
      raise "NIF rcl_node_fini/1 not implemented"
  end
  def read_guard_condition(_a) do
      raise "haha"
  end

#------------------------------publisher_nif.c--------------------------
  @doc """
      return rcl_publisher_t
      argument...void
  """
  def rcl_get_zero_initialized_publisher do
      raise "NIF get_zero_initialized_publisher/0 not implemented"
  end

  @doc """
      return rcl_publisher_options_t
      argument...void
  """
  def rcl_publisher_get_default_options do
      raise "rcl_get_zero_initialized_publisher/0 not implemented"
  end

  @doc """
      return const char*
      argument...rcl_publisher_t*
  """
  def rcl_publisher_get_topic_name(_a) do
      raise "rcl_get_zero_initialized_publisher/0 not implemented"
  end

  @doc """
      return rcl_ret_t
      argument...rcl_publisher_t*,rcl_node_t*
  """
  def rcl_publisher_fini(_a,_b) do
      raise "rcl_get_zero_initialized_publisher/0 not implemented"
  end

  @doc """
      return rcl_ret_t
      argument...rcl_publisher_t * publisher,
                  const rcl_node_t * node,
                  const rosidl_message_type_support_t * type_support,
                  const char * topic_name,
                  const rcl_publisher_options_t * options
  """
  def rcl_publisher_init(_a,_b,_c,_d) do
      raise "rcl_publisher_init/4 not implemented"
  end
  @doc """
      return bool
      argument...rcl_publisher_t*
  """
  def rcl_publisher_is_valid(_a) do
      raise "rcl_publisher_is_valid/1 not implemented"
  end

  @doc """
    rcl_ret_t
    rcl_publish(
      const rcl_publisher_t * publisher,
      const void * ros_message,
      rmw_publisher_allocation_t * allocation
    );
  """
  def rcl_publish(_a,_b,_c) do
      raise "rcl_publish/3 is not implemented"
  end

  def create_pub_alloc do
    raise "NIF create_pub_alloc/0 is not implemented"
  end
  #---------------------------subscription_nif.c--------------------------
  def rcl_subscription_get_default_options do
    raise "NIF rcl_subscription_get_default_options is not implemented"
  end
  def rcl_get_zero_initialized_subscription do
    raise "NIF rcl_subscription_get_default_options is not implemented"
  end
  def create_sub_alloc do
    raise "NIF create_suballoc/0 is not implemented"
  end
  @doc """
    rcl_ret_t
    rcl_subscription_init(
      rcl_subscription_t * subscription,
      const rcl_node_t * node,
      const rosidl_message_type_support_t * type_support,
      const char * topic_name,
      const rcl_subscription_options_t * options
  );
  """
  def rcl_subscription_init(_a,_b,_c,_d) do
    raise "NIF rcl_subscription_init is not implemented"
  end
  @doc """
      return rcl_ret_t
      argument...rcl_subscription_t*,rcl_node_t*
  """
  def rcl_subscription_fini(_a,_b) do
    raise "NIF rcl_subscription_fini is not implemented"
  end

  def rcl_subscription_get_topic_name(_a) do
    raise "NIF rcl_subscription_get_topic_name/1 is not implemented"
  end
  @doc """
    rcl_ret_t
    rcl_take(
      const rcl_subscription_t * subscription,
      void * ros_message,
      rmw_message_info_t * message_info,
      rmw_subscription_allocation_t * allocation
    );
  """
  def rcl_take(_a,_b,_c,_d) do
    raise "NIF rcl_take is not implemented"
  end
  #def rcl_take_with_null(_a,_b,_c) do
  #  raise "NIF rcl_take_with_null is not implemented"
  #end
  #-----------------------------msg_int16.c------------------------------
  def create_empty_int16 do
    raise "NIF create_empty_int16/0 is not implemented"
  end

  def create_msginfo do
    raise "NIF create_msginfo/0 is not implemented"
  end

  def int16_init(_a) do
    raise "NIF std_msgs__msg__Int16__init/0 not implemented"
  end

  def int16_destroy(_a) do
      raise "NIF std_msgs__msg__Int16__destroy/1 not implemented"
  end

  def get_message_type_from_std_msgs_msg_Int16 do
      raise "NIF get_message_type_from_std_msgs_msg_Int16/0 not implemented"
  end
  def readdata_int16(_a) do
    raise "NIF readdata_int16/1 is not implemented"
  end
  def setdata_int16(_a,_b) do
    raise "NIF setdata_int16/2 is not implemented"
  end
  #def cre_int16 do
  #    get_message_type_from_std_msgs_msg_Int16()
  #end
  #-----------------------msg_string_nif.c-----------------------------

  def create_empty_string do
    raise "NIF create_empty_string/0 is not implemented"
  end
  def string_init(_a) do
    raise "NIF string_init/1 is not implemented"
  end

  #arg..(initialized msg,string)
  def setdata_string(_a,_b,_c) do
    raise "NIF setdata_string/3 is not implemented"
  end

  #user API
  def setdata_string(msg,data) do
    data_size = String.length(data)
    setdata_string(msg,String.to_charlist(data),data_size)
  end
  def readdata_string(_a) do
    raise "NIF readdata_string/1 is not implemented"
  end
  #-----------------------------wait_nif.c------------------------------
  def rcl_get_default_allocator do
    raise "NIF rcl_get_default_allocator/0 is not implemented"
  end
  def rcl_get_zero_initialized_wait_set do
    raise "NIF rcl_get_zero_initialized_wait_set/0 is not implemented"
  end
  def rcl_wait_set_init(_a,_b,_c,_d,_e,_f,_g,_h,_i) do
    raise "NIF rcl_wait_set_init/9 is not implemented"
  end
  def rcl_wait_set_fini(_a) do
    raise "NIF rcl_wait_set_fini/1 is not implemented"
  end
  def rcl_wait_set_clear(_a) do
    raise "NIF rcl_wait_set_clear/1 is not implemented"
  end
  def rcl_wait_set_add_subscription(_a,_b) do
    raise "NIF rcl_wait_set_add_subscription/2 is not implemented"
  end
  def rcl_wait(_a,_b) do
    raise "NIF rcl_wait/0 is not implemented"
  end
  def check_subscription(_a,_b) do
    raise "NIF check_subscription/2 is not implemented"
  end
  def get_sublist_from_waitset(_a) do
    raise "NIF get_sublist_from_waitset/1 is not implemented"
  end
#-#----------------------------use Agent-------------------------
  #use Agent
  #def publisher_start(pub) do
  #  Agent.start_link(fn -> pub end)
  #end
  #def get_topic_name_pub(agent_pid) do
  #  Agent.get(agent_pid,fn(n)->rcl_publisher_get_topic_name(n) end)
  #end
  #def publish(agent_pid,message,pub_alloc) do
  #  Agent.update(agent_pid,fn(n)->rcl_publish(n,message,pub_alloc) end)
  #end
#
  #def subscription_start(sub,msginfo,sub_alloc) do
  #  Agent.start_link(fn -> {:subcription_start,sub,msginfo,sub_alloc} end)
  #end
#
  #def get_topic_name_sub(agent_pid) do
  #  Agent.get(agent_pid,fn(n) -> rcl_subscription_get_topic_name(elem(n,1)) end)
  #end
##
  ##def agentspin(agent_pid,takemsg,callback) do
  #  Agent.update(agent_pid,
  #    fn(n)->
  #      {ret,sub,msginfo,sub_alloc} = case rcl_take(elem(n,1),takemsg,elem(n,2),elem(n,3)) do
  #        {RclEx.Macros.rcl_ret_ok,sub,msginfo,sub_alloc} ->
  #          IO.puts "subscribed"
  #          #callback.(takemsg)
  #        {RclEx.Macros.rcl_ret_subscription_take_failed,sub,msginfo,sub_alloc} ->
  #          IO.puts "rcl_take nothing"
  #          IO.inspect(takemsg)
  #        {_,sub,msginfo,sub_alloc} -> IO.puts "Catch all"
  #      end
  #    end)
#
  #  :timer.sleep(1000)
  #  agentspin(agent_pid,takemsg,callback)
  #end
  #
  #def loop(sub,msg,msginfo,sub_alloc,count,sleep_msec) do
  #  ret = case RclEx.rcl_take(sub,msg,msginfo,sub_alloc) do
  #    {Macro.rcl_ret_ok,sub,msginfo,sub_alloc} -> callback(msg)
  #    {Macro.rcl_ret_subscription_take_failed,sub,msginfo,sub_alloc} -> IO.puts "rcl_take nothing"
  #    {_,sub,msginfo,sub_alloc} -> "Catch all"
  #  end

  #  IO.puts "count=> #{count}"
  #  count = count + 1
  #  :timer.sleep(sleep_msec)
  #  loop(sub,msg,msginfo,sub_alloc,count,sleep_msec)
  #end
#------------------------ユーザAPI群-------------------
  def rclexinit do
    init_op = rcl_get_zero_initialized_init_options()
    context = rcl_get_zero_initialized_context()
    rcl_init_options_init(init_op)
    rcl_init_with_null(init_op,context)
    rcl_init_options_fini(init_op)
    context
  end
  def rclexinit(init_op,context) do
    IO.puts "hello"
    rcl_init_options_init(init_op)
    rcl_init_with_null(init_op,context)
    rcl_init_options_fini(init_op)
  end


  def create_singlenode(context,node_name,node_namespace) do
    node = rcl_get_zero_initialized_node()
    node_op = rcl_node_get_default_options()
    rcl_node_init(node,node_name,node_namespace,context,node_op)
    node
  end
  #引数にnamespace入れてる
  def create_nodes(context,node_name,namespace,num_node) do
    node_list = Enum.map(1..num_node,fn(n)->
                rcl_node_init(
                  rcl_get_zero_initialized_node(),node_name++Integer.to_charlist(n),namespace,context,rcl_node_get_default_options()
                  )
                end)
    node_list
  end
  #引数にnamespace入れない
  def create_nodes(context,node_name,num_node) do
    node_list = Enum.map(1..num_node,fn(n)->
                rcl_node_init_without_namespace(
                  rcl_get_zero_initialized_node(),node_name++Integer.to_charlist(n),context,rcl_node_get_default_options()
                  )
                end)
    node_list
  end

  def single_create_publisher(pub_node,topic_name) do
    publisher = rcl_get_zero_initialized_publisher()
    pub_op = rcl_publisher_get_default_options()
    rcl_publisher_init(publisher,pub_node,topic_name,pub_op)
    publisher
  end

  def create_publishers(node_list,topic_name) do
    Enum.map(node_list,fn(node)->
      rcl_publisher_init(rcl_get_zero_initialized_publisher(),node,topic_name,rcl_publisher_get_default_options())
    end)
  end

  def create_subscribers(node_list,topic_name) do
    Enum.map(node_list,fn(node)->
      rcl_subscription_init(rcl_get_zero_initialized_subscription(),node,topic_name,rcl_subscription_get_default_options())
    end)
  end

  def initialize_msg do
    create_empty_string()
    |> string_init()
  end

  def initialize_msgs(msg_count,:int16) do
    Enum.map(1..msg_count,fn(n) ->
      create_empty_int16()
    end)
  end
  def initialize_msgs(msg_count,:string) do
    Enum.map(1..msg_count,fn(n) ->
      initialize_msg()
    end)
  end


end