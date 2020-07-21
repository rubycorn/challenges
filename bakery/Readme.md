# Coding Challenge Solution
# Requirements
- Ruby = 2.7

# Setup
- go to project's dir
- run `bundle install`
- run `bin/bakery spec/input/correct.txt`

# Specs
- for one-time tests pass run `rspec` in project's dir
= for developing run 'guard -c'

# Notes
The app works with file input, example from challenge pdf located here: `spec/input/correct.txt`
Input file format allows doubled codes, in this case counts for this product will be sum up.
Buns data is stored in `data/buns.yml` so the app can be easily extended with new products without code update.
Challenge pdfs are srored in `data` dir.


