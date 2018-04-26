describe GoogleDrive do

  it 'should not fail with gzip error in httplog' do

    gd = GoogleDrive.new
    expect { gd.do_something }.not_to raise_error # For me it raises: Zlib::GzipFile::Error

  end

end
