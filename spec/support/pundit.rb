def mock_pundit_user_as(person)
  allow_any_instance_of(ApplicationController).to receive(:current_user)
    .and_return(person)
  allow_any_instance_of(ApplicationController).to receive(:current_person)
    .and_return(person)
end
