import Quick
import Nimble

@testable import BeerFacts

class BeerDetailsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("BeerDetailsViewController") {
            
            var subject: BeerDetailsViewController!
            var interactor: MockBeerDetailsInteractor!
            var segueRouter: MockSegueRouter!
            var imageCache: MockImageCache!
            
            let beerName = "BeerName"
            
            beforeEach {
                interactor = MockBeerDetailsInteractor()
                segueRouter = MockSegueRouter()
                imageCache = MockImageCache()

                let storyboard = UIStoryboard(name: "BeerDetails", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "BeerDetailsView") as! BeerDetailsViewController
                subject.inject(interactor: interactor, router: segueRouter, imageCache: imageCache)
                subject.configure(beerName: beerName)
                TestView.displayViewController(subject)
            }

            it("should have sent viewDidLoad to interactor") {
                expect(interactor.event).to(equal(BeerDetailsViewEvent.viewDidLoad(beerName: beerName)))
            }

            describe("perform actions") {
                context("activity spinner, show = true") {
                    beforeEach {
                        subject.perform(action: .showActivityIndicator(true))
                    }

                    it("should have hidden imageview, stackview, and errorLabel ") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.errorLabel)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.imageView)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.stackView)
                    }
                    
                    it("should have shown activity indicator") {
                        self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.activityIndicator)

                    }
                }

                context("activity spinner, show = false") {
                    beforeEach {
                        subject.perform(action: .showActivityIndicator(false))
                    }

                    it("should have hidden activity indicator") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.activityIndicator)
                    }
                }

                context("error message") {
                    let message = "Something bad"

                    beforeEach {
                        subject.perform(action: .errorMessage(message))
                    }

                    it("should have hidden imageView, stackView, and activity spinner") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.activityIndicator)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.stackView)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.activityIndicator)
                    }

                    it("should have shown errorLabel with message") {
                        let label = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.errorLabel) as! UILabel
                        expect(label.text).to(equal(message))
                    }
                }

                context("display view state") {
                    let viewState = BeerDetailsViewState.testMake(
                        name: "Beer",
                        tagline: "Tage line",
                        description: "Beer description",
                        abv: "ABV",
                        ibu: "IBU",
                        imageURL: URL(string: "https://fakeimage.com"),
                        foodPairings: ["Food1", "Food2"])

                    beforeEach {
                        subject.perform(action: .display(viewState))
                    }

                    it("should have hidden errorLabel and activity spinner") {
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.activityIndicator)
                        self.tester().waitForAbsenceOfView(withAccessibilityLabel: BeerListViewController.AccessibilityLabel.errorLabel)
                    }

                    it("should have displayed data from viewState") {
                        let nameLabel = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.nameLabel) as! UILabel
                        let tagLabel = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.tagLabel) as! UILabel
                        let descriptionLabel = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.descriptionLabel) as! UILabel
                        let ibuLabel = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.ibuLabel) as! UILabel
                        let abvLabel = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.abvLabel) as! UILabel
                        
                        expect(nameLabel.text).to(equal(viewState.name))
                        expect(tagLabel.text).to(equal(viewState.tagline))
                        expect(descriptionLabel.text).to(equal(viewState.description))
                        expect(ibuLabel.text).to(equal(viewState.ibu))
                        expect(abvLabel.text).to(equal(viewState.abv))
                    }
                    
                    it("should have called image cache") {
                        let imageView = self.tester().waitForView(withAccessibilityLabel: BeerDetailsViewController.AccessibilityLabel.imageView) as! UIImageView
                        expect(imageCache.inputImageView).to(be(imageView))
                        expect(imageCache.inputImageURL).to(equal(viewState.imageURL))
                    }
                }
            }
        }
    }
}

