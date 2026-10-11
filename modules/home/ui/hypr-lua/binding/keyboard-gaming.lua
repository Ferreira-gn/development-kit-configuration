-- Configuração necessária para o teclado 60%
-- O comando é executado após a combinação ser solta.

local function type_symbol(symbol)
	return hl.dsp.exec_cmd(string.format([[sh -c 'sleep 0.08; wtype -- %q']], symbol))
end

hl.bind("ALT + UP", type_symbol(";"), {
	release = true,
})

hl.bind("ALT + SHIFT + UP", type_symbol(":"), {
	release = true,
})

hl.bind("ALT + ESCAPE", hl.dsp.exec_cmd([[sh -c "sleep 0.08; wtype -- \"'\""]]), {
	release = true,
})

hl.bind("SHIFT + ESCAPE", type_symbol([["]]), {
	release = true,
})
