RSpec.describe TwitterRSS do
  it 'has a version number' do
    expect(TwitterRSS::VERSION).not_to be nil
  end

  it 'create a instance TwitterRSS' do
    TwitterRSS.new({})
  end
end
