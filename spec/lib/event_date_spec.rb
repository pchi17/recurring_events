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
end