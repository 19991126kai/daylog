module ApplicationHelper
  def nav_link_to(name, path, match: :exact, **opts)
    # 共通の基本スタイル
    base = "block rounded px-3 py-2 transition-colors duration-200"

    # アクティブ or 非アクティブで分岐
    if active_for?(path, match)
      # 現在のページ → 背景固定、hover無効
      active = "bg-blue-300 font-medium"
      hover  = ""
    else
      active = "text-white"
      hover  = "hover:bg-white/10"
    end

    # クラス結合
    opts[:class] = [ base, active, hover, opts[:class] ].compact.join(" ")
    link_to name, path, opts
  end

  private

  def active_for?(path, match)
    case match
    when :exact
      current_page?(path)
    when :prefix
      request.path.start_with?(path)
    when Regexp
      request.path.match?(match)
    else
      false
    end
  end
end
