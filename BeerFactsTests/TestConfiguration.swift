import Quick
import KIF

class TestConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Quick.Configuration) {
        KIFEnableAccessibility()
    }
}
