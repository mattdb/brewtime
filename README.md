# Brewtime

This is a sample application, currently under construction. For an overview of the project and some pointers to some of the more interesting code bits, [take a look at the blog series documenting the development of this app,](http://mattdb.com/blog/categories/brewtime/) or read below for an abbreviated version.

In its current state the app is a proof of concept, specifically regarding creating the main brew display using data visualization techniques and the [D3.js library](http://d3js.org/). 

The visualization is drawn using SVG, which means it will display crisply on high-dpi devices like retina displays.

## General idea

Display a concise list of currently fermenting brews and their current progress through the fermentation process to a homebrewer. 

[![SVG Visualization](http://mattdb.com/images/brewtime/datavis-1-cropped.png)](http://mattdb.com/images/brewtime/datavis-1.png)
(Visualization screenshot trimmed, [click for full size](http://mattdb.com/images/brewtime/datavis-1.png))

Each brew has it's current step displayed, with the minimum time expected shaded a dark blue, and the maximum time expected displayed in a lighter shade. "Now" is displayed with a vertical red line.

## Scope

i.e. Things intentionally not included in this app (at least in its current form):

*Multi-user/Authentication/Authorization*: We're assuming a user is running the app locally, there are no security provisions or multi-user functionality. This has been done enough times, no need to show how to do that (again) here.

## Points of interest

* [step.rb](https://github.com/mattdb/brewtime/blob/master/app/models/step.rb) and [associated spec](https://github.com/mattdb/brewtime/blob/master/spec/models/step_spec.rb)
* [brewchart.js.coffee](https://github.com/mattdb/brewtime/blob/master/app/assets/javascripts/include/brewchart.js.coffee) (no spec: BDD-based data visualization is not yet amongst us)
* [index.json.rabl](https://github.com/mattdb/brewtime/blob/master/app/views/brews/index.json.rabl) and [associated spec](https://github.com/mattdb/brewtime/blob/master/spec/views/brews_json_spec.rb)


## To-Do

It's likely many of the things on this list won't actually be done (or at least, very soon), but here's what I would look at implementing to make this a truly complete app:

* ~~Basic models~~
* ~~Basic Visualization~~
* Interactive visualization: clicking a line would fill in an information panel next to/under the main list
* Actual forms to edit/update models
* Display multi-step fermentations (currently the visualization code cheats quite a bit and assumes the first step defined in the json is the "current" step)
* implement scrolling and/or "overview/detail" views to allow for cases with very large date ranges (bulk aging, perhaps)

## Running your own copy

Beyond the normal Rails app setup process, you'll need MongoDB. Mongo was used because of the self-documenting nature of the fields, but we're not really using any special features.

Once you get set up, you'll want to make a few brews, with at least one step. You can use the FactoryGirl factory for your convenience and edit to your liking. For example:

    brew = FactoryGirl.create(:brew_with_steps)
    brew.name = "IIPA"
    s = brew.steps.first
    s.name = "Primary"
    s.max_length = 21      # integer is length in days
    brew.save