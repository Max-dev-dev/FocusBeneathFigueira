import SwiftUI

enum ArticleType: CaseIterable, Identifiable {
    case timeManagement, dailyRest, minimalism, focus, slowingDown, meditation, figTree
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .timeManagement: return "Time Under the Tree: Lessons in Time Management from Nature"
        case .dailyRest: return "How to Organize Your Day to Make Time for Rest"
        case .minimalism: return "Simplicity in Planning: Minimalism for Your Daily Tasks"
        case .focus: return "Secrets to Focus: Creating a Focus-Friendly Environment"
        case .slowingDown: return "The Art of Slowing Down: Avoiding Information Overload"
        case .meditation: return "Meditation Under the Tree: Practices for Better Focus"
        case .figTree: return "The Fig Tree in History and Mythology"
        }
    }
    
    var content: String {
        switch self {
        case .timeManagement:
            return """
            In the hustle of modern life, it’s easy to forget that some of the greatest lessons in time management are rooted in nature. Imagine sitting under a tree. Its branches stretch toward the sun, its roots grow deep into the earth, and its growth happens steadily, season by season. Trees don’t rush, yet they achieve magnificent growth over time.
            Just as trees allocate energy to growth during spring and rest in winter, we should focus on tasks that align with our peak energy levels. Nature works in cycles, and we can plan our year in quarters or seasons, aligning projects with our energy and goals.
            Trees also teach us that rest isn’t idleness but preparation for growth. By scheduling breaks intentionally, we set ourselves up for greater productivity. Like trees that grow gradually, dedicating even ten minutes daily to meaningful work compounds into significant progress.
            Next time you’re overwhelmed, take a moment to sit under a tree. Let it remind you that balance, patience, and consistency are the roots of productivity.
            """
        case .dailyRest:
            return """
            The paradox of productivity is that rest fuels high performance. However, finding time to rest requires intentional planning.
            To create a day that balances work and relaxation, you can dedicate specific time slots for breaks and downtime, just as you would for meetings or work tasks. Starting your day with a morning routine of quiet time, journaling, or stretching sets a calm tone.
            Working in focused blocks of ninety minutes followed by twenty-minute breaks allows for recharging without burnout. Reserve the last hour of your day for non-screen activities, such as reading or meditating, to promote restful sleep.
            Prioritize tasks that matter most and eliminate or delegate the rest. Simplifying your commitments creates space for rest. With a well-organized day, rest becomes not an afterthought but an integral part of your routine, fueling both productivity and joy.
            """
        case .minimalism:
            return """
            The minimalist approach to planning is about doing less but achieving more. It’s not about cramming your day with tasks but focusing on what truly matters.
            Limiting your daily focus to three essential tasks provides clarity, reduces decision fatigue, and increases focus. Decluttering your to-do list and eliminating non-essential tasks that don’t align with your goals can simplify your workload.
            Grouping similar activities, like responding to emails or making calls, saves time and mental energy. Leaving a portion of your schedule open for unforeseen events ensures flexibility. Spending a few minutes at the end of each day to reflect on what worked and what didn’t allows for continuous improvement.
            Minimalist planning is not about perfection but progress. With simplicity comes focus and a sense of accomplishment.
            """
        case .focus:
            return """
            Focus is a skill, but your environment plays a significant role in fostering it. A clean desk reduces distractions and creates mental clarity. Adjusting your workspace’s lighting to use natural light and incorporating soothing sounds or silence helps maintain concentration.
            Defining separate zones for work, relaxation, and recreation signals your brain about the activity. Turning off unnecessary notifications and using tools like website blockers during focus sessions can limit digital distractions.
            Adding plants or natural elements to your space can further enhance your ability to concentrate. Studies show that greenery boosts focus and creativity. With an intentional environment, you’ll find it easier to dive into focused, meaningful work.
            """
        case .slowingDown:
            return """
            Slowing down is an art in today’s fast-paced world. Reducing information intake by setting boundaries for social media and news consumption helps manage mental clutter. Designating daily unplugged time allows you to disconnect from devices and reconnect with yourself.
            Engaging fully in simple activities like walking, cooking, or journaling fosters mindfulness. Focusing on one task at a time deepens your engagement and reduces stress. Taking pride in thoughtful, deliberate actions over quick, hasty ones can transform your approach to tasks.
            The art of slowing down enriches your mental clarity and improves your overall well-being.
            """
        case .meditation:
            return """
            Meditating under a tree offers a serene and grounding experience. Find a quiet spot under a tree where you feel safe and comfortable. Sitting on the ground, close your eyes and visualize your breath flowing like the roots of the tree. Focusing on slow, deep breaths helps to center your mind and calm your thoughts.
            Reflecting on what you’re grateful for during meditation cultivates positivity and mindfulness. Ending your practice by setting an intention for your day, inspired by the strength and calm of the tree, brings a sense of purpose.
            Meditation under a tree reconnects you with nature and improves your ability to focus and stay present.
            """
        case .figTree:
            return """
            The fig tree has been revered across cultures for centuries. In Buddhism, Siddhartha Gautama attained enlightenment under a Bodhi tree, a type of fig tree, symbolizing wisdom and spiritual growth. The fig tree is mentioned numerous times in the Bible as a symbol of abundance and peace.
            In ancient Greece and Rome, figs represented prosperity and fertility. In Hinduism, the fig tree (Peepal) is considered sacred, symbolizing the interconnectedness of life. Today, fig trees represent resilience and deep-rooted growth, making them a powerful metaphor for personal and professional development.
            The fig tree’s legacy is a testament to its profound connection to human history and spirituality.
            """
        }
    }
}
