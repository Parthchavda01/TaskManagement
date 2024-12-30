- Task Management App

This app provides a user-friendly interface for both mobile and tablet devices, allowing users to manage tasks, view task details, and mark tasks as completed or pending.

- Key Features:

Task Management: Create, view, and manage tasks with ease.
Task Search: Search for specific tasks using a search bar.
Task Sorting: Sort tasks by date or completion status.
Responsive Layout: The app is optimized for both mobile and tablet devices.
Task Details: View task details, including creation date, status, and description.
Completion Toggle: Mark tasks as completed or pending using a checkbox.

- How It Operates:

Add Task: Users can add task by tapping floating action button "+" and adding task title and description.
Task List: The main screen displays a list of tasks. Users can scroll through this list and tap on a task to edit a task.And longpress a task to delete a task.
Search Feature: At the top of the screen, there's a search field where users can type to filter tasks based on the title.
Task Sorting: Users can sort the tasks by date or completion status using the menu in the bottom app bar.
Task Details: Users can see full task details in tablet mode.
Theme Toggle: The app allows users to switch between light and dark modes, enhancing user experience based on personal preferences.

- Development Notes:

It is built with Riverpod for state management,
SQLite to store task details,
Hive to store user pref such as apptheme and sort order.

- How to Run the App:

Clone this repository to your local machine.
Install dependencies:
flutter pub get
To run the app in release mode on your device, use the following command:
flutter run --release
