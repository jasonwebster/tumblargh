shared_context "staff.tumblr.com" do
  let(:json) do
    json_path = File.join(FIXTURE_PATH, "data", "staff.tumblr.com-2012-05-06", "posts.json")
    JSON(open(json_path).read)["response"]
  end

  let(:blog) { Tumblargh::Resource::Blog.new("staff.tumblr.com", json) }
  let(:posts) { blog.posts }
end
