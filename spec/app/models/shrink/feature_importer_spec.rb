describe Shrink::FeatureImporter do

  before(:each) do
    @feature_adapter = mock("FeatureAdapter").as_null_object
    @feature_file_manager = mock("FeatureFileManager").as_null_object
  end

  context "#import" do

    before(:each) do
      @feature_importer = Shrink::FeatureImporter.new(@feature_adapter, @feature_file_manager)
    end

    describe "when importing a file" do

      before(:each) do
        @feature = mock("Feature")
        @file_importer = mock("FileImporter", :import => @feature)
        Shrink::FeatureImporter::FileImporter.stub!(:new).and_return(@file_importer)
      end

      it "should perform the import via a FileImporter" do
        Shrink::FeatureImporter::FileImporter.should_receive(:new).with(hash_including(
                :feature_adapter => @feature_adapter,
                :file_path => "some file path")).and_return(@file_importer)
        @file_importer.should_receive(:import)

        perform_import
      end

      it "should return the feature imported from the file" do
        perform_import.should eql(@feature)
      end

      def perform_import
        @feature_importer.import(:file_path => "some file path")
      end
      
    end

    describe "when importing a directory" do

      before(:each) do
        @features = (1..3).collect { |i| mock("Feature#{i}") }
        @directory_importer = mock("DirectoryImporter", :import => @features)
        Shrink::FeatureImporter::DirectoryImporter.stub!(:new).and_return(@directory_importer)
      end

      it "should perform the import via a DirectoryImporter" do
        Shrink::FeatureImporter::DirectoryImporter.should_receive(:new).with(hash_including(
                :feature_adapter => @feature_adapter,
                :feature_file_manager => @feature_file_manager,
                :directory_path => "some directory path")).and_return(@directory_importer)
        @directory_importer.should_receive(:import)

        perform_import
      end

      it "should return the features imported from the directory" do
        perform_import.should eql(@features)
      end

      def perform_import
        @feature_importer.import(:directory_path => "some directory path")
      end

    end

  end

  describe Shrink::FeatureImporter::FileImporter do

    before(:each) do
      @file_importer = Shrink::FeatureImporter::FileImporter.new(
              :file_path => "some file path", :feature_adapter => @feature_adapter)
    end

    context "#import" do

      before(:each) do
        @feature = mock("Feature")
        @feature_adapter.stub!(:to_feature).and_return(@feature)
      end

      it "should import the file via the feature adapter" do
        @feature_adapter.should_receive(:to_feature).with("some file path")

        perform_import
      end

      it "should return the feature created via the feature adapter" do
        perform_import.should eql(@feature)
      end

      def perform_import
        @file_importer.import
      end

    end

  end

end
