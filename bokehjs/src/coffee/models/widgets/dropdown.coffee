import {dropdown} from "bootstrap/dropdown"

import * as p from "core/properties"
import {a, li} from "core/dom"

import {AbstractButton, AbstractButtonView} from "./abstract_button"
import template from "./dropdown_template"

export class DropdownView extends AbstractButtonView
  template: template

  render: () ->
    super()

    items = []
    for item in @model.menu
      if item?
        [label, value] = item
        link = a({}, label)
        link.dataset.value = value
        link.click((e) => @set_value(event.currentTarget.dataset.value))
        itemEl = li({}, link)
      else
        itemEl = li({class: "bk-bs-divider"})
      items.push(itemEl)

    @el.querySelector('.bk-bs-dropdown-menu').appendChild(items)
    @el.querySelector('button').value = @model.default_value
    dropdown(@el.querySelector('button'))
    return @

  set_value: (value) ->
    # Set the bokeh model to value
    @model.value = value
    # Set the html button value to value
    @el.querySelector('button').value = value

export class Dropdown extends AbstractButton
  type: "Dropdown"
  default_view: DropdownView

  @define {
      value:         [ p.String    ]
      default_value: [ p.String    ]
      menu:          [ p.Array, [] ]
    }

  @override {
    label: "Dropdown"
  }
