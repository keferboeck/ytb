require_relative '../lib/people.rb'
require 'json'

describe People do
  json = JSON.parse(File.read(File.join('spec', 'fixtures', 'json', 'valid_people.json')))
  subject(:people) {People.new(:people => json)}

  describe '#filter_by_radius' do
    context 'with valid radius' do
      it 'returns a list of people within the specified radius' do
        expect(people.filter_by_radius(:radius => 100).to_a.size).to eq(2)
      end
    end

    context 'with invalid radius' do
      it 'raises an Invalid Radius exception on string' do
        expect{ people.filter_by_radius(:radius => "A") }.to raise_exception(People::InvalidRadius)
      end

      it 'raises an Invalid Radius exception on negative integer' do
        expect{ people.filter_by_radius(:radius => -50) }.to raise_exception(People::InvalidRadius)
      end

      it 'raises an Invalid Radius exception on positive float' do
        expect{ people.filter_by_radius(:radius => 50.5) }.to raise_exception(People::InvalidRadius)
      end
    end
  end

  describe '#filter_by_column' do
    context 'with valid column' do
      it 'returns a list of people filtered value' do
        expect(people.filter_by_column(:column => "country", :value => "England").to_a.size).to eq(2)
      end
    end

    context 'with invalid column' do
      it 'raises a Invalid Colum exception non existing column' do
        expect{ people.filter_by_column(:column => "xyz", :value => "nan") }.to raise_exception(People::InvalidColumn)
      end
    end
  end

  describe '#sorty_by' do
    context 'with valid column' do
      it 'returns a desc sorted list of people' do
        expect(people.sort_by(:column => "value")[0]["value"]).to eq("3749.61")
      end
    end

    context 'with invalid column' do
      it 'raises a Invalid Colum exception non existing column' do
        expect{ people.sort_by(:column => "xyz") }.to raise_exception(People::InvalidColumn)
      end
    end
  end

  describe '#avg' do
    context 'with valid column' do
      it 'returns a desc sorted list of people' do
        expect(people.avg(:column => "value").round(2)).to eq(3214.67)
      end
    end

    context 'with invalid column' do
      it 'raises a Invalid Colum exception non existing column' do
        expect{ people.avg(:column => "xyz") }.to raise_exception(People::InvalidColumn)
      end
    end
  end
end