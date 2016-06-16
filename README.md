# recurring_events

How to run the app from you local environment:
* 1. fork and clone this repo.
* 2. cd into app's working directory on your local machine.
* 3. run `bundle exec rails server`
* 4. open your browser and go to `http://localhost:3000/`

# Some Assumptions I made:
1. I assume there were only 4 holidays (New Years, Independence Day, Veterans Day, and Christmas Day).
This is because other holidays are dynamic (ie Thanksgiving happens on the 4th Thursday of November),
and sometime Holidays will happen on the weekend and the following Monday becomes an off day, 
and given the time constraint, I cannot validate whether or not November 20 something 10 years from now is 
Thanksgiving or not without a gem.

2. Specs will fail when time passes, this is because calculated_date, delivery_date, and due_date are all dynamic.
They must be in the future, relative to whatever the time it is now. But they should all pass before Independence Day!
In real production code, I would've used the timecop gem.