import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormularioScreen(),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  String _genero = 'Masculino';
  String _estadoCivil = 'Soltero';
  bool _aceptaTerminos = false;

  void _calcularEdad(DateTime fechaNacimiento) {
    DateTime hoy = DateTime.now();
    int edad = hoy.year - fechaNacimiento.year;
    if (hoy.month < fechaNacimiento.month || (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
      edad--;
    }
    _edadController.text = edad.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Color de fondo del AppBar
        title: Center(
          child: Text(
            'Formulario de Registro',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _cedulaController,
                decoration: InputDecoration(
                  labelText: 'Cédula',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su cédula';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombres',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese sus nombres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _apellidoController,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese sus apellidos';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _fechaNacimientoController,
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.orange, // Color del encabezado
                            onPrimary: Colors.white, // Color del texto del encabezado
                            onSurface: Colors.orange, // Color del texto seleccionado
                          ),
                          buttonTheme: ButtonThemeData(
                            textTheme: ButtonTextTheme.primary // Color del botón de aceptar
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaNacimientoController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      _calcularEdad(pickedDate);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione su fecha de nacimiento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _edadController,
                decoration: InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                readOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Género', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text('Masculino'),
                leading: Radio<String>(
                  value: 'Masculino',
                  groupValue: _genero,
                  onChanged: (value) {
                    setState(() {
                      _genero = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Femenino'),
                leading: Radio<String>(
                  value: 'Femenino',
                  groupValue: _genero,
                  onChanged: (value) {
                    setState(() {
                      _genero = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Estado Civil', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text('Soltero'),
                leading: Radio<String>(
                  value: 'Soltero',
                  groupValue: _estadoCivil,
                  onChanged: (value) {
                    setState(() {
                      _estadoCivil = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Casado'),
                leading: Radio<String>(
                  value: 'Casado',
                  groupValue: _estadoCivil,
                  onChanged: (value) {
                    setState(() {
                      _estadoCivil = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Acepto términos y condiciones'),
                leading: Checkbox(
                  value: _aceptaTerminos,
                  onChanged: (value) {
                    setState(() {
                      _aceptaTerminos = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _aceptaTerminos) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Formulario válido y enviado')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Por favor complete el formulario correctamente')),
                        );
                      }
                    },
                    child: Text('Siguiente'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Salir'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






