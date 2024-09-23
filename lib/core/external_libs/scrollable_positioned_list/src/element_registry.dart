// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

class RegistryWidget extends StatefulWidget {
  const RegistryWidget({super.key, this.elementNotifier, required this.child});

  final Widget child;

  final ValueNotifier<Set<Element>?>? elementNotifier;

  @override
  State<StatefulWidget> createState() => _RegistryWidgetState();
}

class RegisteredElementWidget extends ProxyWidget {
  const RegisteredElementWidget({super.key, required super.child});

  @override
  Element createElement() => _RegisteredElement(this);
}

class _RegistryWidgetState extends State<RegistryWidget> {
  final Set<Element> registeredElements = {};

  @override
  Widget build(BuildContext context) => _InheritedRegistryWidget(
        state: this,
        child: widget.child,
      );
}

class _InheritedRegistryWidget extends InheritedWidget {
  const _InheritedRegistryWidget({
    required this.state,
    required super.child,
  });

  final _RegistryWidgetState state;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class _RegisteredElement extends ProxyElement {
  _RegisteredElement(super.widget);

  @override
  void notifyClients(ProxyWidget oldWidget) {}

  late _RegistryWidgetState _registryWidgetState;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    final inheritedRegistryWidget =
        dependOnInheritedWidgetOfExactType<_InheritedRegistryWidget>()!;
    _registryWidgetState = inheritedRegistryWidget.state;
    _registryWidgetState.registeredElements.add(this);
    _registryWidgetState.widget.elementNotifier?.value =
        _registryWidgetState.registeredElements;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final inheritedRegistryWidget =
        dependOnInheritedWidgetOfExactType<_InheritedRegistryWidget>()!;
    _registryWidgetState = inheritedRegistryWidget.state;
    _registryWidgetState.registeredElements.add(this);
    _registryWidgetState.widget.elementNotifier?.value =
        _registryWidgetState.registeredElements;
  }

  @override
  void unmount() {
    _registryWidgetState.registeredElements.remove(this);
    _registryWidgetState.widget.elementNotifier?.value =
        _registryWidgetState.registeredElements;
    super.unmount();
  }
}
