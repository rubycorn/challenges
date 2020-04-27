# Background:

A group event will be created by an user. The group event should run for
a whole number of days e.g.. 30 or 60. There should be attributes to set
and update the start, end or duration of the event (and calculate the other
value). The event also has a name, description (which supports formatting)
and location. The event should be draft or published. To publish all of the
fields are required, it can be saved with only a subset of fields before
it’s published. When the event is deleted/remove it should be kept in the
database and marked as such.


# Deliverable:

Write an AR model, spec and migration for a GroupEvent that would meet the
needs of the description above. Then write the api controller and spec to
support JSON request/responses to manage these GroupEvents. For the purposes
of this exercise, ignore auth. Please provide your solution as a rails app
called exercise_YYMMDD_yourname, sent as a zip file.

# Assumptions:

* Draft with filled but incorrect fields is invalid.
* The event duration includes both dates of the range. It means that the
  event with same start and stop dates is considering as a one-day event.
* Deleted objects shouldn't be removed from DB but they also shouldn't
  be visible after deleting, this behavior can be changed in
  `/app/models/concerns/safe_destroy.rb:6` (please read the comment, lines 4,5)
* Both columns `latitude` and `longitude` are float type and the scale is stricted
  by 5 digits. Float is much faster then decimal but for more precision
  calculations it would be better to use decimal with more digits after dot.