function k_subtitleText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(fontId)
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end