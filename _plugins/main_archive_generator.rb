module TravisSwicegoodGenerators
  class MainArchivePage < BaseArchivePage
    attr_accessor :posts

    def layout_err_msg
      "
Hold your horses!  main_archive_generator plugin, here.

You've enabled me but haven't added a main_archive layout.
At least put an empty file there or I'm not going to run.

Missing file:
  %s/%s.html
" % ["_layouts", @layout]
    end

    def initialize(site, posts)
      @url = "/archives/"
      super(site, posts)
    end

    def data
      super.deep_merge({})
    end
  end

  class MainArchiveGenerator < Jekyll::Generator
    include ArchiveGenerator

    def add_to_bucket(post)
      @bucket[post.date.year] ||= default_bucket
      @bucket[post.date.year][:posts] << post
      @bucket[post.date.year][:subs][post.date.month] ||= default_bucket
      @bucket[post.date.year][:subs][post.date.month][:posts] << post
    end

    def process
      years = []

      @bucket.each_pair do |year, months|
        posts = months[:posts]
        posts.sort! { |a,b| b.date <=> a.date }

        temp_year = {
          'year' => year,
          'posts' => posts,
          'months' => [],
        }

        months[:subs].each_pair do |month, data|
          posts = data[:posts]
          posts.sort! { |a,b| b.date <=> a.date }
          temp_year['months'] << {
            'year' => year,
            'month' => month,
            'posts' => posts,
          }
        end

        temp_year['months'].sort! { |a,b| b['month'] <=> a['month'] }
        years << temp_year
      end

      years.sort! { |a,b| b['year'] <=> a['year'] }

      @site.pages << MainArchivePage.new(@site, years)
    end
  end
end
