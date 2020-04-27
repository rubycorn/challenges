require 'rails_helper'

describe GroupEvent, type: :model do
  describe 'Validations' do
    context 'when draft' do
      let(:event) { build(:event) }

      it 'is valid when empty' do
        expect(build(:empty_event)).to be_valid
      end

      it 'is valid when stop is nil and duration is nil' do
        event.stop = nil
        event.duration = nil
        expect(event).to be_valid
      end

      it 'is valid when stop is nil and duration greater than 1' do
        event.stop = nil
        expect(event).to be_valid
      end

      it 'is invalid when longitude is out of range' do
        event.longitude = 181
        expect(event).not_to be_valid
        event.longitude = -181
        expect(event).not_to be_valid
      end

      it 'is invalid when latitude is out of range' do
        event.latitude = 91
        expect(event).not_to be_valid
        event.latitude = -91
        expect(event).not_to be_valid
      end

      it 'is invalid when stop before start' do
        event.start = Date.today
        event.stop = Date.yesterday
        expect(event).not_to be_valid
      end

      it 'is invalid when stop is nil and duration less than 1' do
        event.stop = nil
        event.duration = 0
        expect(event).not_to be_valid
      end
    end

    context 'when published empty' do
      let(:event) { build(:empty_event) }

      it 'is invalid when required fields are empty' do
        event.draft = false
        expect(event).not_to be_valid
      end
    end

    context 'when published' do
      let(:event) { build(:published_event) }

      it 'is valid when all data filled correctly' do
        expect(event).to be_valid
      end

      it 'is valid when stop is not nil and duration is nil' do
        event.duration = nil
        expect(event).to be_valid
      end

      it 'is valid when stop is nil and duration is not nil' do
        event.stop = nil
        expect(event).to be_valid
      end

      it 'is invalid when stop is nil and duration is nil' do
        event.stop = nil
        event.duration = nil
        expect(event).not_to be_valid
      end
    end
  end

  describe 'Methods' do
    describe '.all' do
      it 'returns only non-deleted events' do
        expect do
          create(:event)
          create(:deleted_event)
        end.to change{ GroupEvent.count }.from(0).to(1)
      end
    end

    describe '#destroy' do
      context 'when event is stored in DB' do
        let!(:event) { create(:event) }

        it 'decrements records count' do
          expect do
            event.destroy
          end.to change{ GroupEvent.count }.from(1).to(0)
        end

        include_examples 'group event'
      end

      context 'when event is new' do
        let(:event) { build(:event) }

        include_examples 'group event'
      end
    end

    describe '#save' do
      let(:event) { build(:event) }

      context 'when start and stop provided' do
        it 'should be saved with duration' do
          expected = event.duration
          event.duration = nil
          event.save
          expect(event.duration).to eq(expected)
        end
      end

      context 'when start and duration provided' do
        it 'should be saved with stop' do
          expected = event.stop
          event.stop = nil
          event.save
          expect(event.stop).to eq(expected)
        end
      end
    end

    describe '#deleted?' do
      context 'when record is not deleted' do
        let!(:event) { create(:event) }

        it 'returns false' do
          expect(event.deleted?).to be_falsey
        end
      end

      context 'when record deleted' do
        let!(:event) { create(:event) }

        it 'returns true' do
          expect(event.deleted?).to be_falsey
          event.destroy
          expect(event.deleted?).to be_truthy
        end
      end
    end
  end
end