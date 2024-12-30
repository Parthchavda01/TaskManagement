// Use DateFormat to format the DateTime object into dd/mm/yyyy format
import 'package:intl/intl.dart';

String formatDateString(DateTime date) {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}

