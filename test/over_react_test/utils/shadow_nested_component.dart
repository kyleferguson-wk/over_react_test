// Copyright 2021 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:over_react/react_dom.dart';

part 'shadow_nested_component.over_react.g.dart';

mixin ShadowNestedProps on UiProps {
  String shadowRootHostTestId;
  String shadowRootFirstChildTestId;
  Ref shadowRootHostRef;
}

UiFactory<ShadowNestedProps> ShadowNested = uiFunction(
  (props) {
    final divRef = props.shadowRootHostRef ?? useRef<DivElement>();

    useEffect(() {
      if (divRef.current.shadowRoot == null) {
        var shadowRootFirstChild = DivElement()..dataset['test-id'] = props.shadowRootFirstChildTestId ?? 'shadowRootFirstChild';
        divRef.current.attachShadow({'mode':'open'}).append(shadowRootFirstChild);
        render(Fragment()(props.children), shadowRootFirstChild);
      }
    }, [props]);

    return (Dom.div()..addTestId(props.shadowRootHostTestId ?? 'shadowRootHost')..ref = divRef)();
  },
  _$ShadowNestedConfig, // ignore: undefined_identifier
);
