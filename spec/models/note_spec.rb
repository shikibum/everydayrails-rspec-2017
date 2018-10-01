require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @user = User.create(
      first_name: 'Haku',
      last_name: 'Otter',
      email: 'haku@example.com',
      password: 'passpass'
    )

    @project = @user.projects.create(
      name: 'Test Project'
    )
  end

  # ユーザー、プロジェクトｍメッセージがあれば有効な状態であること
  it 'is valid with a user, project, and message' do
    note = Note.new(
      message: 'This is a sample note.',
      user: @user,
      project: @project
    )
    expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it 'is valid without a message' do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include('can\'t be blank')
  end

  # 文字列に一致するメッセージを検索する
  describe 'search message for a term' do
    before do
      @note1 = @project.notes.create(
        message: 'This is the first note.',
        user: @user
      )
      @note2 = @project.notes.create(
        message: 'This is the second note.',
        user: @user
      )
      @note3 = @project.notes.create(
        message: 'First, preheat the oven.',
        user: @user
      )
    end

    # 一致するデータが見つかるとき
    context 'when a match is found' do
      # 検索文字列に一致するメモをかえすこと
      it 'return notes that match the seach term' do
        expect(Note.search('first')).to include(@note1, @note3)
      end
    end

      # 一致するデータが見つからないとき
      context 'when no match is found' do
        it 'return an empty collection' do
          expect(Note.search('message')).to be_empty
        end
      end
    end
end

