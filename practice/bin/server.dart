import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

final _router = Router()
  ..get('/', _rootHandler) // / 를 붙이면 _rootHandler 실행
  ..get(
      '/echo/<message>', _echoHandler); // /echo/<message> 를 붙이면 _echoHandler 실행

Response _rootHandler(Request req) {
  // HelloWorld 출력 함수
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  // <message>에 들어있는 문자열 출력 함수
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);
  final port =
      int.parse(Platform.environment['PORT'] ?? '8080'); // 포트 8080으로 정하기
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
