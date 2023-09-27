import coreLib from '../../utilities/coreLibrary';
import exitApplicationModalContent from '../../contents/exitApplicationModalContent.js';

class exitApplicationModal {
    /**
     * Define Account Selection Elements
     */

    //Content elements

    get exitApplicationHeaderText() {
        return $("[data-ref='heading']");
    }

    get exitApplicationBodyText() {
        return $("[data-ref='exitApplicationModalBodyText.text']");
    }

    //Interactable elements

    get exitApplicationLink() {
        return $("[data-ref='exitApp.linkContent']");
    }

    get exitApplicationButton() {
        return $("[data-ref='exitApplicationModalExitButton.button']");
    }

    get cancelExitApplicationButton() {
        return $("[data-ref='exitApplicationModalCancelButton.button']");
    }

    get closeExitApplicationModalButton() {
        return $("[data-ref='exitApplicationModal.modalClose.button']");
    }

    /*************************
     * Exit Application Modal Methods
     *************************/

    /******************
     * Action Methods
     ******************/

    clickExitApplicationLink() {
        coreLib.click(this.exitApplicationLink);
    }

    clickExitApplicationButton() {
        coreLib.click(this.exitApplicationButton);
    }

    clickCancelExitApplicationButton() {
        coreLib.click(this.cancelExitApplicationButton);
    }

    clickCloseExitApplicationModalButton() {
        coreLib.click(this.closeExitApplicationModalButton);
    }

    isOpen(){
        browser.waitForUrl("https://www.nationwide.co.uk/",1000);
        return browser.pageLoaded();
    }

    /******************
     * Validation Methods
     ******************/

    validateExitModalContent() {
        let header = coreLib.getText(this.exitApplicationHeaderText);
        expect(header).to.equal(exitApplicationModalContent.heading);

        let body = coreLib.getText(this.exitApplicationBodyText);
        expect(body).to.equal(exitApplicationModalContent.body);

        let exitButtonText = coreLib.getText(this.exitApplicationButton);
        expect(exitButtonText).to.equal(exitApplicationModalContent.exitButtonText);

        let cancelButtonText = coreLib.getText(this.cancelExitApplicationButton);
        expect(cancelButtonText).to.equal(exitApplicationModalContent.cancelButtonText);
    }

    validateExitModalLink() {
        let link = coreLib.getText(this.exitApplicationLink);
        expect(link).to.equal(exitApplicationModalContent.link);
    }
}
export default new exitApplicationModal();
