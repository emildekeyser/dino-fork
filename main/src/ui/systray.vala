namespace Dino.Ui {

    public class SysTray {

        private StatusNotifier.Item sni;

        public signal void activate();

        public SysTray()
        {

            var category = StatusNotifier.Category.APPLICATION_STATUS;
            string icon_name = "im.dino.Dino";
            sni = new StatusNotifier.Item.from_icon_name("dino", category, icon_name);
            
            sni.set_status(StatusNotifier.Status.ACTIVE);
            sni.set_title("Dino");
            sni.set_item_is_menu(true);

            sni.set_from_icon_name(StatusNotifier.Icon.ICON, icon_name);
            sni.set_from_icon_name(StatusNotifier.Icon.ATTENTION_ICON, icon_name);
            sni.set_from_icon_name(StatusNotifier.Icon.OVERLAY_ICON, icon_name);
            sni.set_from_icon_name(StatusNotifier.Icon.TOOLTIP_ICON, icon_name);


            sni.activate.connect((_x, _y) => {
                activate();
                return true;
            });
            // sni.context_menu.connect(show_menu); // TODO
            // sni.secondary_activate.connect(show_menu); // TODO

            sni.registration_failed.connect((error) => {
                warning("Registration of StatusNotifierItem (systray) failed: " + error.message);
            });

        }

        public void enable()
        {
            sni.register();
        }

        public void disable()
        {
            // TODO
        }
        
        // private void show_menu(int x, int y) // TODO
}
}
