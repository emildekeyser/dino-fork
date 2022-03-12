namespace Dino.Ui {

    public class SysTray {

        private StatusNotifier.Item sni;
        private Gtk.Widget mainwindow;

        public SysTray(Gtk.Widget mainwindow)
        {

            this.mainwindow = mainwindow;

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


            sni.context_menu.connect(show_menu); // TODO does not work atm with xapps SNI Host (Cinnamon etc)
            sni.secondary_activate.connect(show_menu);
            sni.activate.connect(show_menu);
            /* sni.scroll.connect((delta, orientation) => { make_menu(0, 0); return true; }); */

            sni.registration_failed.connect((error) => {
                warning("Registration of StatusNotifierItem (systray) failed: " + error.message);
            });

            sni.register();

        }

        private bool show_menu(int x, int y)
        {

            // TODO It seems that if this here is done in a more straitforward
            // way (without the timeout) then it is possible (observed on
            // Cinnamon with the 'xapps' program as SNI Watcher/Host) that the
            // click event that generated the Activate SNI method also causes
            // the popup to immedietly dissapear ie not show up at all.

            Timeout.add(100, () => {
                make_menu();
                return Source.REMOVE;
            });
            return true;
        }

        private void make_menu()
        {
            var menu = new Gtk.Menu();
            Gtk.Widget widget;

            widget = new Gtk.MenuItem.with_label("Show");
            widget.button_press_event.connect(() => {
                mainwindow.show();
                return true;
            });
            widget.show();
            menu.attach(widget, 0, 1, 0, 1);

            widget = new Gtk.MenuItem.with_label("Quit");
            widget.button_press_event.connect(() => {
                Dino.Application.get_default().quit();
                return true;
            });
            widget.show();
            menu.attach(widget, 0, 1, 1, 2);

            menu.popup(null, null, null, 3, Gtk.get_current_event_time());
        }

    }

}
