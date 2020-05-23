
import UIKit
import paper_onboarding

class OnboardPage: UIViewController {
    
    let onboardViewModel = OnboardViewModel()
    let onboarding = PaperOnboarding()
    @IBOutlet weak var nextPage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPaperOnboardingView()
        nextPage.layer.cornerRadius = 25
    }

    @IBAction func nextToPage(_ sender: Any) {
        
    }
    
}

extension OnboardPage: PaperOnboardingDataSource,PaperOnboardingDelegate {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return onboardViewModel.items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
        if onboarding.currentIndex == 2 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.nextPage.alpha = 1
                
            }, completion: nil)        }else{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.nextPage.alpha = 0
            }, completion: nil)
        }
    }
}

extension OnboardPage{
    
    private func setupPaperOnboardingView() {
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        onboarding.addSubview(nextPage)

            // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
        let constraint = NSLayoutConstraint(item: onboarding,attribute: attribute,relatedBy:.equal,toItem: view,attribute: attribute,multiplier: 1,constant: 0)
                view.addConstraint(constraint)
            }
    }
}
