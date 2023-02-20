# frozen_string_literal: true

Kaminari.configure do |config|
  # config.default_per_page = 25
  # config.max_per_page = nil
  config.window = 3
  # 現在のページから、左右何ページ分のリンクを表示させるか(デフォルトは4件)
  # config.window = 4
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  config.page_method_name = :page
  config.param_name = :page
  # ページ番号を渡すために使用するパラメータ名(デフォルトは:page)
  # ↑Board.page(params[:page])のようにparamsメソッドで取得できる。
  config.max_pages = nil
  # 最大ページ数(デフォルトはnil）
  # config.params_on_first_page = false
end
