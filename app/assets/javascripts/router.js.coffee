Base.Router.reopen
  location: 'history'
  rootURL: '/'

###
This router seems to be automatically created by
`Base = Ember.Application.Create()` in application.js.

If I wanted/needed to make my own, I'd do this:
  Base.Router = Ember.Router.extend()

Routes in templates work like this:
  {{#linkTo "car.new"}}Make a new car{{/linkTo}}

Or if the template context isn't bound to a single model, you can
pass a parameter to the `linkTo`:
  {{#linkTo "car.edit" this}}Edit this car{{/linkTo}}

... like we do in `cars/index.hbs`
###
Base.Router.map ->
#  @route 'gallery'

  # This is what they show you in the ember guides
  @resource 'posts', ->
    @route 'show', path: '/:post_id'
  @resource 'galleries', ->
    @route 'show', path: '/:gallery_id'
  @resource 'pages', ->
    @route 'show', path: '/:page_id'
