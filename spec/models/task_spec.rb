require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    @current_user = User.find_by(email: "adminadmino@piyopiyo.com")
  end

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '', content: '企画書を作成する。',
          updated_at: '2025/02/19',
          deadline_on: '2025/02/19',
          priority: 1,
          status: 1,
          user_id: @current_user.id)
        expect(task).not_to be_valid
      end
    end

    context 'タスクの説明が空文字の場合' do
      it 'バリデーションに失敗する' do
        task = Task.create(title: '資料作成', content: '',
          updated_at: '2025/02/19',
          deadline_on: '2025/02/19',
          priority: 1,
          status: 1,
          user_id: @current_user.id)
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと説明に値が入っている場合' do
      it 'タスクを登録できる' do
        task = Task.create(title: '資料作成', content: '企画書を作成する。',
          updated_at: '2025/02/19',
          deadline_on: '2025/02/19',
          priority: 1,
          status: 1,
          user_id: @current_user.id)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:first_task) { FactoryBot.create(:first_task, title: 'first_task_title', user_id: @current_user.id) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task_title', user_id: @current_user.id) }
    let!(:third_task) { FactoryBot.create(:third_task, title: 'third_task_title', user_id: @current_user.id) }
    
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索ワードを含むタスクが絞り込まれる' do
        # タイトルの検索メソッドをsearch_titleとしてscopeで定義した場合のコード例
        # scopeを使って定義した検索メソッドに検索ワードを挿入する
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
        expect(Task.search_title('first')).to include(first_task)
        expect(Task.search_title('first')).not_to include(second_task)
        expect(Task.search_title('first')).not_to include(third_task)
        expect(Task.search_title('first').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_status('0')).to include(first_task)
        expect(Task.search_status('0')).not_to include(second_task)
        expect(Task.search_status('0')).not_to include(third_task)
        expect(Task.search_status('0').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索ワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        expect(Task.search_title('first').search_status('0')).to include(first_task)
        expect(Task.search_title('first').search_status('0')).not_to include(second_task)
        expect(Task.search_title('first').search_status('0')).not_to include(third_task)
        expect(Task.search_title('first').search_status('0').count).to eq 1
      end
    end
  end
end