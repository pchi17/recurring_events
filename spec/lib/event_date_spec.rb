require 'rails_helper'
require 'event_date'

RSpec.describe EventDate do
  describe '::new' do
    context 'given an out of range date' do
      before(:all) { @date = EventDate.new(2016, 2, 31) }
      it 'finds the closest previous valid date' do
        expect(@date.year).to  eq(2016)
        expect(@date.month).to eq(2)
        expect(@date.day).to   eq(29)
      end
      it 'keeps track of the original day argument' do
        expect(@date.original_day).to eq(31)
      end
    end
    
    context 'given an in range date' do
      before(:all) { @date = EventDate.new(2016, 7, 4) }
      it 'initializes the date as given' do
        expect(@date.year).to  eq(2016)
        expect(@date.month).to eq(7)
        expect(@date.day).to   eq(4)
      end
      it 'keeps track of the original day argument' do
        expect(@date.original_day).to eq(4)
      end
    end
  end
  
  describe '#increment_months' do
    context 'given an out of range date' do
      it 'it increments x months based on original day argument' do
        date = EventDate.new(2016, 2, 31)
        
        new_date = date.increment_months
        expect(new_date.year).to  eq(2016)
        expect(new_date.month).to eq(3)
        expect(new_date.day).to   eq(31)
        
        new_date = date.increment_months(2)
        expect(new_date.year).to  eq(2016)
        expect(new_date.month).to eq(4)
        expect(new_date.day).to   eq(30)
      end
    end
    
    context 'when increments to december' do
      it 'it does not set month to 0' do
        date = EventDate.new(2016, 6, 31)
        
        new_date = date.increment_months(6)
        expect(new_date.year).to  eq(2016)
        expect(new_date.month).to eq(12)
        expect(new_date.day).to   eq(31)
      end
    end
    
    context 'when increments to january next year' do
      it 'it does sets month to 1 and increments year by 1' do
        date = EventDate.new(2016, 6, 31)
        
        new_date = date.increment_months(7)
        expect(new_date.year).to  eq(2017)
        expect(new_date.month).to eq(1)
        expect(new_date.day).to   eq(31)
      end
    end
  end
  
  describe 'is_weekend?' do
    it 'returns true for saturday' do
      date = EventDate.new(2016, 6, 18)
      expect(date.saturday?).to be(true)
      expect(date.is_weekend?).to be(true)
    end
    it 'returns true for sunday' do
      date = EventDate.new(2016, 6, 19)
      expect(date.sunday?).to be(true)
      expect(date.is_weekend?).to be(true)
    end
    it 'returns false for weekdays (ie tuesday)' do
      date = EventDate.new(2016, 6, 14)
      expect(date.tuesday?).to be(true)
      expect(date.is_weekend?).to be(false)
    end
  end
  
  describe 'is_new_years_day?' do
    it 'returns true for new years day' do
      date = EventDate.new(2016, 1, 1)
      expect(date.is_new_years_day?).to be(true)
    end
    it 'returns false for any other day, such as NYE' do
      date = EventDate.new(2015, 12, 25)
      expect(date.is_new_years_day?).to be(false)
    end
  end
  
  describe 'is_independence_day?' do
    it 'returns true for July 4th' do
      date = EventDate.new(2016, 7, 4)
      expect(date.is_independence_day?).to be(true)
    end
    it 'returns false for any other day, such as June 4th' do
      date = EventDate.new(2015, 6, 4)
      expect(date.is_independence_day?).to be(false)
    end
  end
  
  describe 'is_veterans_day?' do
    it 'returns true for November 11th' do
      date = EventDate.new(2016, 11, 11)
      expect(date.is_veterans_day?).to be(true)
    end
    it 'returns false for any other day, such as November 10th' do
      date = EventDate.new(2016, 11, 10)
      expect(date.is_veterans_day?).to be(false)
    end
  end
  
  describe 'is_christmas?' do
    it 'returns true for December 25th' do
      date = EventDate.new(2016, 12, 25)
      expect(date.is_christmas?).to be(true)
    end
    it 'returns false for any other day, such as Christmas Eve' do
      date = EventDate.new(2016, 12, 24)
      expect(date.is_christmas?).to be(false)
    end
  end
  
  describe 'is_thanksgiving?' do
    it 'returns true for November 24th 2016' do
      date = EventDate.new(2016, 11, 24)
      expect(date.is_thanksgiving?).to be(true)
    end
    it 'returns false for any other day in 2016, such as November 17th' do
      date = EventDate.new(2016, 11, 17)
      expect(date.is_thanksgiving?).to be(false)
    end
  end
  
  describe 'is_memorial_day?' do
    it 'returns true for May 30th 2016' do
      date = EventDate.new(2016, 5, 30)
      expect(date.is_memorial_day?).to be(true)
    end
    it 'returns false for any other day in 2016, such as May 31st' do
      date = EventDate.new(2016, 5, 31)
      expect(date.is_memorial_day?).to be(false)
    end
  end
  
  describe 'is_holiday?' do
    it 'returns true for Independence Day 2016' do
      date = EventDate.new(2016, 7, 4)
      expect(date.is_holiday?).to be(true)
    end
    it 'returns true for Thanksgiving Day 2016' do
      date = EventDate.new(2016, 11, 24)
      expect(date.is_holiday?).to be(true)
    end
    it 'returns false for any "normal" day in 2016, such as June 10' do
      date = EventDate.new(2016, 6, 10)
      expect(date.is_holiday?).to be(false)
    end
  end
end