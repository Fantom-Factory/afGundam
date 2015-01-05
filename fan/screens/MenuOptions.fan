using gfx
using fwt

@Js @NoDoc
class MenuOptions {

	Int? selectedIndex
	|->|? escFunc
	private MenuOption[] menuOptions := [,]

	Void add(Str text, Str desc, Int line, |MenuOption, Key|? func := null) {
		menuOption := MenuOption(text, desc, line, func)
		menuOptions.add(menuOption)
		if (selectedIndex == null)
			selectedIndex = menuOptions.size - 1
	}
	
	Void each(|MenuOption| f) {
		menuOptions.each |menuOption, index| {
			menuOption.selected = (selectedIndex == index) 
			f(menuOption)
		}
	}
	
	Void onKeyDown(Event event) {
		if (event.key == Key.down) {
			Ioc.sounds.menuMove.play
			selectedIndex++
			if (selectedIndex >= menuOptions.size)
				selectedIndex = 0
		}

		if (event.key == Key.up) {
			Ioc.sounds.menuMove.play
			selectedIndex--
			if (selectedIndex < 0)
				selectedIndex = menuOptions.size - 1
		}

		if (event.key == Key.esc) {
			escFunc?.call
		}

		if (event.key == Key.enter) {
			Ioc.sounds.menuSelect.play
		}
		
		if (event.key == Key.enter || event.key == Key.left || event.key == Key.right) {
			if (selectedIndex != null) {
				option := menuOptions[selectedIndex]
				option.func(option, event.key)
			}
		}
	}
}



@Js @NoDoc
class MenuOption {

	Str text
	Str desc
	Int line
	|MenuOption, Key|? func
	Bool selected := false
	
	new make(Str text, Str desc, Int line, |MenuOption, Key|? func := null) {
		this.text = text
		this.desc = desc
		this.line = line
		this.func = func
	}
}