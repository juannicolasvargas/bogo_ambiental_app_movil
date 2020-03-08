import 'package:bogo_ambiental_app_movil/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class IncidentBloc with Validators {
  final _titleController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _imageController = BehaviorSubject<String>();

    // Recuperar los datos del Stream
  Stream<String> get titleStream    => _titleController.stream.transform(validateTitle);
  Stream<String> get descriptionStream => _descriptionController.stream.transform(validateDescription);
  Stream<String> get imageStream     => _imageController.stream;

  Stream<bool> get forValidStream =>
    Observable.combineLatest3(titleStream, descriptionStream, imageStream, (e, p, i) => true);

    // Insertar valores al Stream
  Function(String) get changeTitle    => _titleController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  Function(String) get changeimage => _imageController.sink.add;

  // Obtener ultimo valor ingresado
  String get title => _titleController.value;
  String get description => _descriptionController.value;
  String get image => _imageController.value;

  dispose() {
    _titleController?.close();
    _descriptionController?.close();
    _imageController?.close();
  }
}