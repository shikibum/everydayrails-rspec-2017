require 'rails_helper'

RSpec.describe Note, type: :model do
  #検索文字列に一致するメモを返すこと
  it 'return notes that match the seach term' do
    user = User.create(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )

    project = user.projects.create(
      name: 'Test Project'
    )

    note1 = project.notes.create(
      message: 'This is the first note.',
      user: user
    )
    note2 = project.notes.create(
      message: 'This is the second note.',
      user: user
    )
    note3 = project.notes.create(
      message: 'First, preheat the oven.',
      user: user
    )

    expect(Note.search('first')).to include(note1, note3)
    expect(Note.search('first')).to_not include(note2)
  end

  # 検索結果が1件も見つからなければカラのコレクションを返すこと
  it 'return an empty collection when no results are found' do
    user = User.create(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )

    project = user.projects.create(
      name: 'Test Project'
    )

    note1 = project.notes.create(
      message: 'This is the first note.',
      user: user
    )
    note2 = project.notes.create(
      message: 'This is the second note.',
      user: user
    )
    note3 = project.notes.create(
      message: 'First, preheat the oven.',
      user: user
    )
    expect(Note.search('message')).to be_empty
  end
end
