# Два простых приложения (одно написанное на Erlang, второе на C), которые обмениваются ZMQ-сообщениями

Проект демонстрирует взаимодействие C и Erlang через ZeroMQ.

C-клиент отправляет сообщение (REQ), Erlang-сервер принимает его, выводит в erlshell полученное сообщение и отвечает клиенту(REP).


## Требования

- GCC (build-essential)
- CMake (≥ 3.10)
- Erlang/OTP (≥ 25)
- Git

## Сборка

```bash
git clone https://github.com/sharipadze-hash/zmq_project.git
cd zmq_project
make
```

## Запуск

### Терминал 1: Erlang-сервер

```bash
make run
```

### Терминал 2: C-клиент

```bash
./bin/send "Hello from C!"
```

## Лицензия

Проект использует:
- libzmq (LGPL 3.0+)
- chumak (MPL 2.0)
