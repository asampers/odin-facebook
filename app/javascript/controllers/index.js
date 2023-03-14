// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AutoclickController from "./autoclick_controller"
application.register("autoclick", AutoclickController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import ResetFormController from "./reset_form_controller"
application.register("reset-form", ResetFormController)

import TurboController from "./turbo_controller"
application.register("turbo", TurboController)
