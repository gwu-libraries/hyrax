# frozen_string_literal: true

RSpec.describe Hyrax::VisibilityReader do
  subject(:reader) { described_class.new(resource: resource) }
  let(:resource)   { Hyrax::Resource.new }

  let(:open) { Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC }
  let(:auth) { Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED }

  describe '#read' do
    context 'when public group can read' do
      before { resource.read_groups = [open] }

      it 'is open' do
        expect(reader.read).to eq 'open'
      end
    end

    context 'when authenticated group can read' do
      before { resource.read_groups = [auth] }

      it 'is authenticated' do
        expect(reader.read).to eq 'authenticated'
      end

      it 'and public can also read is open' do
        resource.read_groups += [open]
        expect(reader.read).to eq 'open'
      end
    end

    context 'when neither group can read' do
      it 'is restricted' do
        expect(reader.read).to eq 'restricted'
      end
    end
  end
end
