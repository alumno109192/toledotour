import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/email_service.dart';

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final List<File> _attachments = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'contact_us')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context, 'contact_form_description'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),

                    // Campo nombre
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: tr(context, 'name'),
                        prefixIcon: const Icon(Icons.person),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr(context, 'name_required');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: tr(context, 'email'),
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr(context, 'email_required');
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return tr(context, 'email_invalid');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo asunto
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: tr(context, 'subject'),
                        prefixIcon: const Icon(Icons.subject),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr(context, 'subject_required');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo mensaje
                    TextFormField(
                      controller: _messageController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: tr(context, 'message'),
                        prefixIcon: const Icon(Icons.message),
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr(context, 'message_required');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Sección de adjuntos
                    Text(
                      tr(context, 'attachments'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),

                    // Botones para añadir adjuntos
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.photo),
                            label: Text(tr(context, 'add_photo')),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _pickFile,
                            icon: const Icon(Icons.attach_file),
                            label: Text(tr(context, 'add_file')),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Lista de adjuntos
                    if (_attachments.isNotEmpty) ...[
                      Text(
                        tr(context, 'attached_files'),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(_attachments.length, (index) {
                        final file = _attachments[index];
                        return Card(
                          child: ListTile(
                            leading: _getFileIcon(file.path),
                            title: Text(_getFileName(file.path)),
                            subtitle: Text(_getFileSize(file)),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeAttachment(index),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                    ],

                    // Botón enviar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _sendEmail,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send),
                        label: Text(
                          _isLoading
                              ? tr(context, 'sending')
                              : tr(context, 'send'),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Removed ads from contact form - not editorial content
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _attachments.add(File(image.path));
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _attachments.add(File(result.files.single.path!));
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  Widget _getFileIcon(String path) {
    final extension = path.split('.').last.toLowerCase();

    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return const Icon(Icons.image, color: Colors.blue);
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'doc':
      case 'docx':
        return const Icon(Icons.description, color: Colors.blue);
      case 'mp3':
      case 'wav':
      case 'm4a':
        return const Icon(Icons.audiotrack, color: Colors.orange);
      case 'mp4':
      case 'avi':
      case 'mov':
        return const Icon(Icons.video_file, color: Colors.purple);
      default:
        return const Icon(Icons.insert_drive_file, color: Colors.grey);
    }
  }

  String _getFileName(String path) {
    return path.split('/').last;
  }

  String _getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Usar el servicio de email con el cliente predeterminado del dispositivo
      final success = await EmailService.sendEmailWithDefaultClient(
        recipientEmail: 'soporte@toledotour.com',
        subject: _subjectController.text,
        body:
            _messageController.text +
            EmailService.getAttachmentsInfo(_attachments),
        senderName: _nameController.text,
        senderEmail: _emailController.text,
        attachments: _attachments,
      );

      if (!mounted) return;

      if (success) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr(context, 'email_sent_success')),
            backgroundColor: Colors.green,
          ),
        );

        // Limpiar formulario
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
        setState(() {
          _attachments.clear();
        });
      } else {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr(context, 'email_send_error')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${tr(context, 'email_send_error')}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
