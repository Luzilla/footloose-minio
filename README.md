# footloose-minio

 - starts a 4 node cluster of minio
 - services opened:
     - ssh: 22 (2222, 2223, 2224, 2225)
     - minio: 9000 (9000, 9001, 9002, 9003)

## commands

Everything is driven by a `Makefile`.

 - `make start` - starts the cluster and provisions minio
 - `make debug` - checks cluster status (is minio running and distributed)
 - `make clean` - to remove (almost) everything

Once the cluster is provisioned, add an "alias" for it to your configuration:

```
$ mc config host add footloose-minio http://127.0.0.1:9000 foo barbarbar
```

Display the cluster status like so:

```
$ mc admin info footloose-minio
●  minio1:9000
   Uptime: 52 minutes
   Version: 2020-01-25T02:50:51Z
   Network: 4/4 OK
   Drives: 1/1 OK
●  minio2:9000
   Uptime: 51 minutes
   Version: 2020-01-25T02:50:51Z
   Network: 4/4 OK
   Drives: 1/1 OK
●  minio3:9000
   Uptime: 52 minutes
   Version: 2020-01-25T02:50:51Z
   Network: 4/4 OK
   Drives: 1/1 OK
●  minio0:9000
   Uptime: 52 minutes
   Version: 2020-01-25T02:50:51Z
   Network: 4/4 OK
   Drives: 1/1 OK

4 drives online, 0 drives offline
```

## requirements

 - Docker (recent)
 - [footloose](https://github.com/weaveworks/footloose)
 - `ansible` (and `ansible-galaxy`)
 - MinIO's `mc`
