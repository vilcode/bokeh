import * as p from "core/properties"

import {AbstractButton, AbstractButtonView} from "./abstract_button"

export class ToggleView extends AbstractButtonView

  render: () ->
    super()
    if @model.active
      @el.querySelector('button').classList.add("bk-bs-active")
    else
      @el.querySelector('button').classList.remove("bk-bs-active")
    return @

  change_input: () ->
    super()
    @model.active = not @model.active

export class Toggle extends AbstractButton
  type: "Toggle"
  default_view: ToggleView

  @define {
    active: [ p. Bool, false ]
  }

  @override {
    label: "Toggle"
  }
