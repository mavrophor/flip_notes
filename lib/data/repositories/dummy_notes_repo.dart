import 'dart:math';

import 'package:flip_notes/data/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v8.dart';

class DummyNotesRepo {
  final rng = Random(1);
  final uuid = const UuidV8();

  Future<List<Note>> getList() async {
    return await _generateNotes(amount: 12);
  }

  Future<Note> create({
    required String title,
    required String contentFront,
    required String contentBack,
    required Color color,
    Set<String>? tags,
  }) async {
    final now = DateTime.now();
    return Note(
      id: uuid.generate(),
      title: title,
      contentFront: contentFront,
      contentBack: contentBack,
      color: color,
      tags: tags ?? {},
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<List<Note>> _generateNotes({required int amount}) async {
    final List<Note> list = [];
    final now = DateTime.now();
    for (final i in Iterable.generate(amount)) {
      final note = Note(
        id: uuid.generate(),
        title: 'Note #$i',
        contentFront: loremList[rng.nextInt(12)],
        contentBack: loremList[rng.nextInt(12)],
        color: Colors.primaries[rng.nextInt(Colors.primaries.length)],
        tags: {for (var t = 0; t < rng.nextInt(3); t++) tags[rng.nextInt(tags.length)]},
        createdAt: now,
        updatedAt: now,
      );
      list.add(note);
    }
    return list;
  }
}

const tags = ['Work', 'Personal', 'Reminder', 'Idea', 'Thought', 'Organizer'];
const loremList = [
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultricies, nisi eu accumsan accumsan, est dolor dictum tortor, non pellentesque purus justo sit amet leo. Donec venenatis, dolor sit amet accumsan laoreet, eros nunc tristique nisl, eget egestas nibh quam at ante. Quisque in risus felis. Aliquam fermentum viverra ipsum id scelerisque. Aliquam finibus justo sit amet arcu malesuada, sit amet feugiat lacus sodales. Nulla pulvinar faucibus arcu, id imperdiet diam sollicitudin porttitor. Nunc finibus est in purus vulputate, eu accumsan ex dignissim. Quisque et consequat metus. Praesent rutrum velit in ultricies ultrices. Mauris diam turpis, venenatis eget massa ut, maximus malesuada sem.',
  'Donec blandit ullamcorper arcu sed mollis. Proin finibus, felis eu posuere iaculis, nisl nulla tempor augue, non dictum dolor lorem consectetur augue. Donec in lorem ligula. Suspendisse potenti. Aenean fermentum nec magna id hendrerit. Duis sit amet efficitur enim. Praesent faucibus sem nec malesuada ultricies. Quisque laoreet posuere ante non scelerisque. Praesent hendrerit purus orci, at hendrerit ex mollis eget. Maecenas est est, faucibus id venenatis at, vulputate vitae eros. Donec orci odio, dapibus sed dignissim quis, rhoncus in eros. Pellentesque tincidunt auctor turpis. Suspendisse eu justo sollicitudin, sodales eros in, accumsan purus. Mauris laoreet volutpat fermentum.',
  'Praesent sodales quis dui ac suscipit. Duis eleifend orci a turpis venenatis tincidunt. Sed ac efficitur orci. Suspendisse id lobortis lectus, quis facilisis eros. Proin sollicitudin lectus ipsum, sit amet hendrerit nisi finibus vel. Quisque non est purus. Suspendisse arcu massa, fringilla tempor vestibulum eu, egestas sit amet enim. Fusce placerat diam eu dolor posuere, nec pellentesque justo pulvinar. Nulla sollicitudin urna pulvinar est tincidunt rutrum.',
  'Duis dictum rutrum placerat. Integer facilisis nulla at libero posuere egestas. Nullam iaculis non nunc ut pellentesque. Pellentesque nec finibus dolor. Sed eu massa sed massa scelerisque pellentesque sit amet non ipsum. Aenean bibendum, massa non viverra aliquam, libero dolor blandit magna, ac euismod odio elit in tortor. Ut at nunc malesuada, porttitor lectus eu, porttitor mauris. Vivamus sagittis, eros nec dapibus dignissim, mi tortor consequat neque, sed tempus mauris est ut augue. Aenean non metus at neque sodales euismod. Vestibulum faucibus magna in ipsum pellentesque efficitur. Maecenas vel ultricies orci.',
  'Donec in augue diam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce pretium ante sit amet porttitor bibendum. Praesent gravida metus dolor, ut finibus sem tempor ac. Integer pellentesque laoreet lectus vel bibendum. Aliquam quis tempor leo, nec facilisis massa. Aenean pharetra turpis iaculis scelerisque scelerisque. Ut sagittis, nibh non ultrices luctus, nisi purus faucibus felis, at varius sapien enim eu nulla. Aliquam vitae enim tellus. Suspendisse ac imperdiet mauris. Vestibulum vitae auctor lacus. Fusce efficitur, velit vel rhoncus tincidunt, tellus ex fermentum arcu, vel lacinia leo nisl vitae orci. Duis sodales congue nunc non lacinia. Maecenas fermentum, nisl vel sagittis ullamcorper, nunc erat commodo purus, non vestibulum elit nisi eget urna. Cras purus ipsum, porttitor ut sapien quis, varius tristique ipsum.',
  'Mauris placerat nunc vel purus suscipit, id lobortis metus ornare. Ut a magna pretium, suscipit velit vel, aliquam nibh. Sed id augue eu dui commodo porta vitae at eros. Aenean nisl velit, tincidunt aliquet ante nec, lacinia rutrum orci. Sed vitae porta velit. Nunc vulputate nunc in porta vehicula. Mauris venenatis lacus velit, a gravida sem pellentesque ut.',
  'Nunc quis massa vel lorem eleifend ornare. Aenean nibh augue, molestie ac egestas sit amet, volutpat sed nisl. Aliquam vel convallis lorem, non maximus ex. Integer eu urna eros. Fusce nec ante quis urna efficitur laoreet. Duis at urna nec nunc accumsan semper a a nunc. Quisque ut lorem ut metus ullamcorper blandit. Aenean vehicula odio malesuada mi consectetur, sit amet tempor risus cursus.',
  'Sed massa tellus, gravida sit amet aliquam eu, sollicitudin in enim. Proin iaculis lectus at tellus ultrices finibus. Cras blandit libero id aliquam molestie. Aliquam sit amet nulla in nisi auctor egestas. Pellentesque porta sodales purus, in viverra nulla ornare vel. Curabitur dapibus est sit amet ipsum dignissim tempus. Curabitur justo odio, suscipit ut odio a, ornare suscipit nisi. Etiam vehicula nisl at leo pulvinar, auctor accumsan sem maximus.',
  'In metus justo, vulputate sed facilisis vel, dapibus commodo turpis. Praesent in porta enim. Praesent eget est a mi posuere maximus. Nam ut augue eget urna facilisis rhoncus. Vestibulum et eros sit amet tellus consequat scelerisque in at neque. Sed tempor dignissim urna, mattis pharetra magna placerat id. Suspendisse maximus efficitur sollicitudin.',
  'Donec lorem orci, sollicitudin eget posuere eget, mollis sit amet dolor. Vivamus a est gravida, vehicula nisi et, mattis orci. Sed efficitur suscipit lacinia. Suspendisse id efficitur turpis. Vivamus vehicula felis lacinia justo rutrum elementum. Donec faucibus augue erat, et maximus enim faucibus ac. Nulla vitae vulputate nibh. Etiam sem lacus, vestibulum ac consectetur sed, varius sed mauris. Ut a bibendum ipsum, quis aliquam eros. Quisque ultricies blandit suscipit. Quisque aliquet facilisis sem. Quisque sed elit ut ipsum rutrum posuere eget sed lorem. Vestibulum accumsan eros et ligula tristique pretium. Fusce tincidunt tortor lobortis elit aliquet, at blandit erat convallis. Aliquam pellentesque nisl ut nisl tempus volutpat. Sed efficitur ex vitae nisl ultrices, non fringilla ipsum venenatis.',
  'Fusce eu arcu viverra, sagittis ipsum ut, consequat ante. Duis quis elit ut nisi iaculis molestie sed nec neque. Sed sed nisl vitae felis porta dignissim. Phasellus rhoncus vehicula luctus. Proin aliquam sem non sapien varius feugiat. Duis pharetra ac lacus non rutrum. Duis consequat dignissim elit eget aliquet. Proin blandit, risus vulputate rutrum mattis, sapien dui hendrerit risus, at blandit odio tortor eu dui. Fusce pulvinar fringilla sem ac molestie. Mauris id lectus efficitur, placerat tellus vitae, fermentum risus. Donec sollicitudin felis sed eros condimentum, sed luctus risus aliquam.',
  'Phasellus sodales lectus sed interdum sodales. Ut sagittis ullamcorper quam et venenatis. Pellentesque tincidunt nunc ut metus blandit pulvinar. In convallis lobortis imperdiet. Vivamus blandit tellus nec orci vulputate, id imperdiet felis pellentesque. Praesent venenatis maximus ipsum non malesuada. Vestibulum laoreet nisl risus, quis tristique nisl aliquam id. Proin porttitor ante at efficitur ultrices. Nullam sit amet odio in enim commodo feugiat. Etiam eu augue velit. Curabitur vel faucibus mi. '
];
