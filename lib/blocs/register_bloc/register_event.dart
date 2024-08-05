 


import 'package:equatable/equatable.dart';

import '../../Networks/models/register_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterTextFieldChangedEvent extends RegisterEvent {
  
}

class RegisterStartedEvent extends RegisterEvent {
  final RegisterModel model;

const  RegisterStartedEvent(this.model);
}

class RegisterSuccessEvent extends RegisterEvent {
  final String successMessage;

const  RegisterSuccessEvent(this.successMessage);
}

class RegisterFailedEvent extends RegisterEvent {
  final String errorMessage;

 const RegisterFailedEvent(this.errorMessage);
}
