Chunked Hello World test
==========================

~~~bash
$ git clone https://github.com/mkorszun/chunked_hello_world.git; cd chunked_hello_world
$ cctrlapp APP_NAME create custom --buildpack https://github.com/cloudControl/buildpack-erlang-kernel.git
$ cctrlapp APP_NAME/default push
$ cctrlapp APP_NAME/default deploy
~~~

Response is splitted into 3 chunks. You can modify time gaps between chunked responses setting env variables (default values T1=50s, T2=70s / Chunk1 -> T1 -> Chunk2 -> T2 -> Chunk3):

~~~bash
$ cctrlapp APP_NAME/default addon.add configdev.free --CHUNKED_TIMEOUT1=50 --CHUNKED_TIMEOUT2=70
~~~

Chunked:

curl -i -v APP_NAME.devcctrl.com/chunked

curl -i -v APP_NAME.cctrlp.com/chunked

Normal:

curl -i -v APP_NAME.devcctrl.com

curl -i -v APP_NAME.cctrlp.com

**or you can use already deployed version with default timeout values under: chunkedhelloworld.devcctrl.com**
