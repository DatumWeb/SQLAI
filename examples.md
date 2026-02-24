# Example Questions and Responses

## Working Examples

### Example 1: Simple Count Query
**Question:** "How many knives do I have?"

**Generated SQL:**
```sql
SELECT COUNT(*) FROM knife;
```

**Response:** "You have 7 knives in your collection."

---

### Example 2: Filtering by Attribute
**Question:** "What knives use bearings?"

**Generated SQL:**
```sql
SELECT * FROM knife WHERE pivot_type = 'bearings';
```

**Response:** "You have 6 knives that use bearings: Squid Trainer, BRS Replicant, Glidr Arctic, BRS Alpha Beast, Squid Krake Raken, and Maxace Serpent Striker."

---

### Example 3: Aggregation with Grouping
**Question:** "What is the average difficulty of tricks by category?"

**Generated SQL:**
```sql
SELECT category, AVG(difficulty) as average_difficulty FROM trick GROUP BY category;
```

**Response:** "The average difficulty by category is: aerial tricks average 2.8, combo tricks average 3.8, rollover tricks average 2.4, and transition tricks average 2.5."

---

### Example 4: Join Query
**Question:** "Show me all tricks I've mastered with their difficulty levels"

**Generated SQL:**
```sql
SELECT t.name, t.difficulty, t.category
FROM trick t
JOIN trick_progress tp ON t.trick_id = tp.trick_id
WHERE tp.mastered = 1;
```

**Response:** "You have mastered 15 tricks including Basic Open (difficulty 1), Y2K (difficulty 2), Zen Rollover (difficulty 2), Aerial (difficulty 2), Twirl (difficulty 2), Chaplin (difficulty 3), Index Rollover (difficulty 2), and several others."

---

### Example 5: Average Calculation
**Question:** "What is my average success rate for aerials?"

**Generated SQL:**
```sql
SELECT AVG(st.success_rate) as avg_success_rate
FROM session_tricks st
JOIN trick t ON st.trick_id = t.trick_id
WHERE t.category = 'aerial';
```

**Response:** "Your average success rate for aerial tricks across all practice sessions is approximately 0.68 (68%)."

---

### Example 6: Complex Query with Multiple Joins
**Question:** "Which knives have I practiced the most tricks with?"

**Generated SQL:**
```sql
SELECT k.name, k.brand, COUNT(DISTINCT tp.trick_id) as tricks_learned
FROM knife k
JOIN trick_progress tp ON k.knife_id = tp.knife_id
GROUP BY k.knife_id, k.name, k.brand
ORDER BY tricks_learned DESC;
```

**Response:** "You've practiced the most tricks with the Squid Trainer (5 tricks), BRS Replicant (5 tricks), and Glidr Arctic (4 tricks)."

---

### Example 7: Date Filtering
**Question:** "What tricks did I practice in May 2024?"

**Generated SQL:**
```sql
SELECT DISTINCT t.name, t.category
FROM trick t
JOIN session_tricks st ON t.trick_id = st.trick_id
JOIN practice_session ps ON st.session_id = ps.session_id
WHERE ps.session_date >= '2024-05-01' AND ps.session_date < '2024-06-01';
```

**Response:** "In May 2024, you practiced: Basic Open, Y2K, Zen Rollover, Aerial, Ladder, Fan, Twirl, Chaplin, Scissor, Ice Pick Aerial, Shortstop, and Scissor to Aerial."

---

### Example 8: Maintenance History
**Question:** "When was the last time I maintained my BRS Replicant?"

**Generated SQL:**
```sql
SELECT me.maintenance_date, me.maintenance_type, me.notes
FROM maintenance_event me
JOIN knife k ON me.knife_id = k.knife_id
WHERE k.name = 'BRS Replicant'
ORDER BY me.maintenance_date DESC
LIMIT 1;
```

**Response:** "The last maintenance on your BRS Replicant was on April 15, 2024, when you applied pivot oil."

---

## Examples That Didn't Work Well

### Example 1: Ambiguous Question
**Question:** "Tell me about my practice"

**Generated SQL:**
```sql
SELECT * FROM practice_session;
```

**Issue:** The query works but the question is too vague. The response lists all practice sessions but doesn't provide meaningful insights or answer a specific question.

**Better Question:** "How many practice sessions have I done this month?"

---

### Example 2: Complex Temporal Query
**Question:** "What tricks did I learn last week?"

**Generated SQL:**
```sql
SELECT t.name
FROM trick t
JOIN trick_progress tp ON t.trick_id = tp.trick_id
WHERE tp.date_first_learned >= date('now', '-7 days');
```

**Issue:** The query assumes "last week" means the last 7 days, but the sample data is from May 2024. This might not match user expectations if they mean calendar week.

**Better Question:** "What tricks did I learn in May 2024?"

---

### Example 3: Natural Language Ambiguity
**Question:** "Show me hard tricks"

**Generated SQL:**
```sql
SELECT * FROM trick WHERE difficulty > 3;
```

**Issue:** "Hard" is subjective. The threshold of difficulty > 3 might not match user expectations. Some might consider difficulty 4+ hard, others might say 3+.

**Better Question:** "What are the most difficult tricks?"

---

## Additional Example Questions

1. **Question:** "How many tricks are in each category?"
   - Tests GROUP BY and COUNT aggregation

2. **Question:** "What is the total practice time across all sessions?"
   - Tests SUM aggregation

3. **Question:** "Which trick has the highest average success rate?"
   - Tests JOIN, AVG, and ORDER BY

4. **Question:** "Show me all knives that need maintenance"
   - Tests date comparison and filtering

5. **Question:** "What tricks have I not mastered yet?"
   - Tests WHERE clause with boolean filtering

6. **Question:** "Which practice session was the longest?"
   - Tests MAX aggregation

7. **Question:** "What is the average confidence level for mastered tricks?"
   - Tests AVG with WHERE clause

8. **Question:** "How many maintenance events has each knife had?"
   - Tests COUNT with GROUP BY and JOIN
