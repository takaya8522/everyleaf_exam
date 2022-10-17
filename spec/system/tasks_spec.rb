require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: '書類作成'
        fill_in '内容', with: '企画書を作成する'
        click_button '登録する'
        expect(page).to have_content '書類作成'
      end
    end
  end

  describe '一覧表示機能' do
      # let!を使ってテストデータを変数として定義することで、複数のテストでテストデータを共有できる
      let!(:first_task) { FactoryBot.create(:first_task, title: 'task_title1') }
      let!(:second_task) { FactoryBot.create(:second_task, title: 'task_title2') }
      let!(:third_task) { FactoryBot.create(:third_task, title: 'task_title3') }
      let(:forth_task) { FactoryBot.create(:task) }
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      before do
        visit tasks_path
      end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        task_list = all('body tr')
        expect(task_list[1].text).to have_content 'task_title1'
        expect(task_list[2].text).to have_content 'task_title2'
        expect(task_list[3].text).to have_content 'task_title3'
      end
    end

    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        task = forth_task.title
        visit tasks_path
        task_list = all('body tr')
        expect(task_list[1].text).to have_content '書類作成'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it 'そのタスクの内容が表示される' do
        @task = FactoryBot.create(:task)
        visit tasks_path(@task)
        expect(page).to have_content '書類作成'
      end
    end
  end

  # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #       FactoryBot.create(:task)
  #       visit tasks_path
  #       # わざと間違った結果を期待値として設定
  #       binding.irb
  #       expect(page).to have_content '企画の予算案を作成する。'
  #     end
  #   end
  # end
end