#ifdef __cplusplus
extern "C"
{
#endif

#include <erl_nif.h>
#include <rcl/rcl.h>
#include <rosidl_generator_c/message_type_support_struct.h>

#include <std_msgs/msg/string.h>

#include "../../include/total_nif.h"
#include "../../include/msg/msg_string_nif.h"
#include "rmw/types.h"

//必要なのはcreate_empty_msg

//空のStringメッセージオブジェクトを作る関数
ERL_NIF_TERM nif_create_empty_string(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]){
    if(argc != 0){
        return enif_make_badarg(env);
    }
    std_msgs__msg__String* res;
    ERL_NIF_TERM ret;
    res = enif_alloc_resource(rt_String,sizeof(std_msgs__msg__String));
    if(res == NULL) return enif_make_badarg(env);
    ret = enif_make_resource(env,res);
    //enif_release_resource(res);

    return ret;
}

//init関数
ERL_NIF_TERM nif_string_init(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]){
  if(argc != 1){
    return enif_make_badarg(env);
  }
  ERL_NIF_TERM ret;
  std_msgs__msg__String* res_msg;
  if(!enif_get_resource(env,argv[0],rt_String,(void**)&res_msg)){
      return enif_make_badarg(env);
  }
  
  std_msgs__msg__String__init(res_msg);
  ret = enif_make_resource(env,res_msg);
  return ret;

}

//std_msgs__msg__Stringのdataに文字列を入れる関数
ERL_NIF_TERM nif_setdata_string(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]){
    if(argc != 2){
        return enif_make_badarg(env);
    }
    std_msgs__msg__String* res_msg;
    ERL_NIF_TERM ret;

    if(!enif_get_resource(env,argv[0],rt_String,(void**)&res_msg)){
        return enif_make_badarg(env);
    }

    char data_buf[128];   //この値がデータサイズの上限を変更する
    (void)memset(&data_buf,'\0',sizeof(data_buf));
    int size = 0;
    if(!enif_get_string(env,argv[1],data_buf,sizeof(data_buf),ERL_NIF_LATIN1)){
        return enif_make_badarg(env);
    }
    
    //String型の構造体に引数の文字列とサイズを入れる．
    rosidl_generator_c__String__assign(res_msg,data_buf);

    return enif_make_atom(env,"ok");
}
ERL_NIF_TERM nif_readdata_string(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]){
    if(argc != 1){
        return enif_make_badarg(env);
    }
    std_msgs__msg__String* res_msg;
    if(!enif_get_resource(env,argv[0],rt_String,(void**)&res_msg)){
        return enif_make_badarg(env);
    }
    return enif_make_tuple2(env,atom_ok,enif_make_string(env,res_msg->data.data,ERL_NIF_LATIN1));
}
#ifdef __cplusplus
}
#endif

