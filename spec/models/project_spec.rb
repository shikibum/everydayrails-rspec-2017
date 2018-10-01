require 'rails_helper'

RSpec.describe Project, type: :model do
  # ユーザー単位では重複したプロジェクト名は許可しない
  it 'does not allow duplicate project names per user' do
    user = User.create(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )

    user.projects.create(
      name: 'Test Project'
    )
    new_project = user.projects.build(
      name: 'Test Project'
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include('has already been taken')
  end

  # 二人のユーザーが同じ名前を使うことは許可する
  it 'allows two users to share a project name' do
    user = User.create(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )

    user.projects.create(
      name: 'Test Project'
    )

    other_user = User.create(
      first_name: 'Yamato',
      last_name: 'Otter',
      email: 'yamato@example.com',
      password: 'passpass'
    )

    other_project = other_user.projects.build(
      name: 'Test Project'
    )

    expect(other_project).to be_valid
  end
end
