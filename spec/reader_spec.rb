require_relative '../lib/reader.rb'

describe Reader do
  describe "#import" do
    let(:json_file) { File.join('spec', 'fixtures', 'json', file_name) }

    context 'when resource is found' do
      context 'when content is valid json format' do
        let(:file_name) { 'valid_people.json' }

        it 'parses content of file' do
          expect(Reader.import(json_file).size).to eq(3)
        end
      end

      context 'when content is invalid json format' do
        let(:file_name) { 'invalid_people.json' }

        it 'raises an JSON::ParserError exception' do
          expect { Reader.import(json_file) }.to raise_exception(JSON::ParserError)
        end
      end
    end

    context 'when resource is not found' do
      let(:file_name) { 'does_not_exist.json' }

      it 'raises an ArgumentError exception' do
        expect { Reader.import(json_file) }.to raise_exception(Reader::InvalidFile)
      end
    end
  end
end