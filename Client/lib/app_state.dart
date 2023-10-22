import 'package:web_socket_channel/web_socket_channel.dart';

class AppState {
  late WebSocketChannel channel;

  AppState() {
    /// Create the WebSocket channel
    /// Todo: Switch to wss
    /// Todo: Make this configuration based
    /// Todo: Should I make a new WrebSocketChannel with ping interval?
    channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:8000/ws'),
    );

    // We can await the ready if we want to wait for a connection
    channel.ready.then((_) {
      print("Ready.");
      channel.sink.add("Hello from Flutter");
    },
        onError: (error) {
          print("Ready error: " + error.toString());
        }
    );

    /// Listen for all incoming data
    channel.stream.listen(
          (data) {
        print("Got data: " + data.toString());
      },
      onError: (error) {
        print(error.toString());
      },
      onDone: () {
        print("Websocket is done.");
      },
    );

    /*
    For sending data, channel.sink.add
     */
  }
}
