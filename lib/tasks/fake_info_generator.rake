namespace :fake_info_generator do

  desc "Generate 2 projects with 3 discussions with 5 comments each"

  task :projects_and_tasks_and_discussions_and_comments => :environment do

    ids = User.select("id")

    User.all.each do |u| 

      2.times do

        project = u.projects.create(title: Faker::Lorem.word, description: Faker::Lorem.sentence(3), due_date: Faker::Date.forward(60) )
        3.times do
          discussion = project.discussions.create(title: Faker::Lorem.word, description: Faker::Lorem.sentence(3), user_id: ids.sample.id )

          2.times do 
            discussion.comments.create(body: Faker::Lorem.sentence(3), user_id: ids.sample.id )
          end
        end

        5.times do 
          project.tasks.create(title: Faker::Company.bs, body: Faker::Lorem.sentence(2), due_date: Faker::Date.forward(30), status: [false, true].sample, user_id: ids.sample.id )
        end
      end
    end

  end
end
