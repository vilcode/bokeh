import * as p from "core/properties"

import {build_views, remove_views} from "core/build_views"
import {empty} from "core/dom"
import {Widget, WidgetView} from "./widget"
import template from "./button_template"

export class AbstractButtonView extends WidgetView
  events:
    "click": "change_input"
  template: template

  initialize: (options) ->
    super(options)
    @icon_views = {}
    @connect(@model.change, @render)
    @render()

  remove: () ->
    remove_views(@icon_views)
    super()

  render: () ->
    super()

    icon = @model.icon
    if icon?
      build_views(@icon_views, [icon], {parent: @})
      for own key, val of @icon_views
        val.el.parentNode?.removeChild(val.el)

    empty(@el)
    html = @template(@model.attributes)
    @el.appendChild(html)

    buttonEl = @el.querySelector('button')

    if icon?
      buttonEl.insertBefore("&nbsp;", buttonEl.firstChild)
      buttonEl.insertBefore(@icon_views[icon.id].el, buttonEl.firstChild)

    buttonEl.disabled = @model.disabled

    return @

  change_input: () ->
    @model.callback?.execute(@model)


export class AbstractButton extends Widget
  type: "AbstractButton"
  default_view: AbstractButtonView

  @define {
    callback:    [ p.Instance          ]
    label:       [ p.String, "Button"  ]
    icon:        [ p.Instance          ]
    button_type: [ p.String, "default" ] # TODO (bev)
  }
